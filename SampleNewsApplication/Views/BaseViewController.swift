//
//  BaseViewController.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 11/02/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView!
    var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLoadingView()
    }
    
    func setupLoadingView() {
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        loadingView.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
    
    func showAlert(message: String, action: @escaping ()->()) {
        let alertVc = UIAlertController(title: "News", message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            action()
        }))
        self.present(alertVc, animated: true)
    }
}

enum NewsType: String, CaseIterable {
    case articals
    case reports
    case blogs
    
    var listAPI: String {
        switch self {
        case .articals:
            return "/v4/articles/"
        case .reports:
            return "/v4/reports/"
        case .blogs:
            return "/v4/blogs/"
        }
    }
}

struct SharedManager {
    static var shared = SharedManager()
    
    var currentNewsType = NewsType.articals
    let baseURL = "https://api.spaceflightnewsapi.net"
    
    var currentAPI: String {
        baseURL + currentNewsType.listAPI
    }
}
