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
    
    var currentID: Int?
    
    var results: Results? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.getNewsDetails(id: self.currentID ?? 0)
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
        if gesture.direction == .right {
            self.getNewsDetails(id: (self.currentID ?? 0) + 1)
            
        } else if gesture.direction == .left {
            self.getNewsDetails(id: (self.currentID ?? 0) - 1)
           
        }
    }
    
    func getNewsDetails(id: Int){
        self.startLoading()
        DetailsViewModels().fetchNewsDetails(id: (id)) { (result: Result<Results, Error>) in
            switch result {
            case .success(let articles):
                self.results = articles
                self.currentID = id
                self.UIUpdates()
                self.stopLoading()
            case .failure(let error):
                print("Error fetching articles: \(error.localizedDescription)")
                self.stopLoading()
            }
        }
    }
    func UIUpdates() {
        DispatchQueue.main.async {
            if let imageURL = URL(string: self.results?.image_url ?? "") {
                self.newsImage.load(url: imageURL)
            }
            self.statusLbl.text = DateFormatChanges().dateFormatChange(value: self.results?.updated_at ?? "")
            self.newTitleLbl.text = self.results?.title ?? ""
            self.summaryLbl.text = self.results?.summary ?? ""
            self.categoryLbl.text = self.results?.news_site ?? ""
        }
    }
    @IBAction func moreOptionAction(_ sender: Any) {
        if let siteURL = URL(string: self.results?.url ?? "") {
            UIApplication.shared.open(siteURL)
        }
       
    }
    @IBAction func bookMarkAction(_ sender: Any) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
