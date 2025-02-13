//
//  NewsDetailsViewController.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//

import UIKit

class NewsDetailsViewController: BaseViewController {

    @IBOutlet weak var summaryLbl: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var newTitleLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    var detailsVM = DetailsViewModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.getNewsDetails(id: self.detailsVM.currentID ?? 0)
        self.addSwipeGestures()
    }
    
    func addSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        self.startLoading()
        if gesture.direction == .right {
            self.detailsVM.nextPage { result in
                self.fetch(result: result)
            }
            
        } else if gesture.direction == .left {
            self.detailsVM.previousPage { result in
                self.fetch(result: result)
            }
        }
    }
    
    func fetch(result: Result<Bool, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.UIUpdates()
            case .failure:
                self.showAlert(message: "No News Found") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            self.stopLoading()
        }
    }
    
    func getNewsDetails(id: Int){
        self.startLoading()
        self.detailsVM.fetchNewsDetails(id: (id)) { result in
            self.fetch(result: result)
        }
    }
    func UIUpdates() {
        DispatchQueue.main.async {
            if let imageURL = URL(string: self.detailsVM.results?.image_url ?? "") {
                self.newsImage.load(url: imageURL)
            }
            self.statusLbl.text = DateFormatChanges().dateFormatChange(value: self.detailsVM.results?.updated_at ?? "")
            self.newTitleLbl.text = self.detailsVM.results?.title ?? ""
            self.summaryLbl.text = self.detailsVM.results?.summary ?? ""
            self.categoryLbl.text = self.detailsVM.results?.news_site ?? ""
        }
    }
    @IBAction func moreOptionAction(_ sender: Any) {
        if let siteURL = URL(string: self.detailsVM.results?.url ?? "") {
            UIApplication.shared.open(siteURL)
        }
       
    }
    @IBAction func bookMarkAction(_ sender: Any) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
