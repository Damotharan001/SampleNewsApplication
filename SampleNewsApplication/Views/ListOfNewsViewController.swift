//
//  ListOfNewsViewController.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//

import UIKit

class ListOfNewsViewController: BaseViewController {

    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    var newsListVM = NewsListViewModels()
    let refreshControl = UIRefreshControl()
    var isLoading = false {
        didSet {
            if isLoading {
                self.startLoading()
            } else {
                self.stopLoading()
            }
        }
    }
    
    fileprivate func addFilterMenu() {
        var elements = [UIMenuElement]()
        NewsType.allCases.forEach { type in
            let element = UIAction(title: type.rawValue.capitalized, state: SharedManager.shared.currentNewsType == type ? .on : .off) { action in
                SharedManager.shared.currentNewsType = NewsType(rawValue: action.title.lowercased()) ?? .articals
                self.addFilterMenu()
                self.getListOfNews()
            }
            elements.append(element)
        }
        self.filterBtn.menu = UIMenu(title: "Select news type", children: elements)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.register(UINib(nibName: "ListOfNewsCell", bundle: nil), forCellReuseIdentifier: "ListOfNewsCell")
        collectionView.register(UINib(nibName: "NewsCategoryCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryCell")
        self.tableView.showsVerticalScrollIndicator = false
        addFilterMenu()
        self.getListOfNews()
        self.setupRefreshControl()
        self.getCategoryList()
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshNews() {
        self.newsListVM.fetchMoreDetails(url: self.newsListVM.newsList?.previous ?? "") { _ in
            self.newsListVM.downloadAllImage {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.tableView.reloadData()
                }
            }
        }
        refreshControl.endRefreshing()
    }
    
    func getCategoryList() {
        self.newsListVM.fetchCategoryList { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getListOfNews(){
        self.isLoading = true
        self.newsListVM.fetchNews { _ in
            self.newsListVM.downloadAllImage {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func filterAction(_ sender: Any) {
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ListOfNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = self.newsListVM.getResults() else {
            return 0
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.newsListVM.getResults()?.count == indexPath.row {
            self.newsListVM.fetchMoreDetails(url: self.newsListVM.newsList?.next ?? "") { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfNewsCell", for: indexPath) as? ListOfNewsCell
            cell?.newsImage.setImage(from: self.newsListVM.getResults()?[indexPath.row].image_url ?? "")
            cell?.newsName.text = self.newsListVM.getResults()?[indexPath.row].title ?? ""
            cell?.dateLbl.text = DateFormatChanges().dateFormatChange(value: self.newsListVM.getResults()?[indexPath.row].updated_at ?? "")
            cell?.personImg.setImage(from: self.newsListVM.getResults()?[indexPath.row].url ?? "")
            cell?.newsCategory.text = self.newsListVM.getResults()?[indexPath.row].news_site ?? ""
            cell?.personName.text = self.newsListVM.getResults()?[indexPath.row].authors?.first?.name ?? ""
            
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sID = String(describing: NewsDetailsViewController.self)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: sID) as? NewsDetailsViewController
        vc?.detailsVM.currentID = self.newsListVM.getResults()?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == tableView else {
            return
        }
        
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) && !isLoading {
            self.isLoading = true
            self.newsListVM.fetchMoreDetails(url: self.newsListVM.newsList?.next ?? "") { _ in
                self.newsListVM.downloadAllImage {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            }
        }
    }
}
extension ListOfNewsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.newsListVM.searchResult(searchValue: textField.text ?? "") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching articles: \(error.localizedDescription)")
            }
        }
        return true
    }
}

extension ListOfNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsListVM.getCategoryList()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryCell", for: indexPath) as? NewsCategoryCell
        cell?.categoryLbl.text = self.newsListVM.getCategoryList()?[indexPath.item]
        if newsListVM.selectedCategory == cell?.categoryLbl.text || (cell?.categoryLbl.text?.lowercased() == "all" && newsListVM.selectedCategory == nil) {
            cell?.categoryLbl.textColor = .white
            cell?.categoryView.backgroundColor = .tintColor
            
            cell?.categoryView.borderWidth = 0.0
        } else {
            cell?.categoryLbl.textColor = .tintColor
            cell?.categoryView.backgroundColor = .white
            cell?.categoryView.borderWidth = 1.0
            cell?.categoryView.borderColor = .tintColor
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.newsListVM.selectCategory(name: self.newsListVM.getCategoryList()?[indexPath.item] ?? "")
        
        if self.newsListVM.getResults()?.isEmpty == true {
            self.showAlert(message: "No News Found") {
                self.newsListVM.selectCategory(name: nil)
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
        } else {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}
