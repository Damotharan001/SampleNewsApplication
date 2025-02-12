//
//  NewsViewModels.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//
import Foundation
import UIKit

class NewsListViewModels {
    let dispatchGroup = DispatchGroup()
    var newsList: NewsList? = nil
    var categoryInfoList: Info? = nil
    var selectedCategory: String?
    
    
    func fetchNews(completion: @escaping (Result<Bool, Error>) -> Void) {
        let api = SharedManager.shared.currentAPI
        fetchResult(url: api, completion: completion)
    }
    
    func downloadAllImage(completion: @escaping ()->Void) {
        ImageCacheManager.shared.reset()
        newsList?.results?.forEach({ result in
            guard let image_url = result.image_url else {
                return
            }
            dispatchGroup.enter()
            ImageCacheManager.shared.loadImage(from: image_url) { [weak self] _ in
                self?.dispatchGroup.leave()
            }
        })
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func fetchCategoryList(completion: @escaping (Result<Bool, Error>) -> Void) {
        let baseURL = "\(SharedManager.shared.baseURL)/v4/info/"
        APIHandler().fetchDetails(baseURL: baseURL) { (result: Result<Info, Error>) in
            switch result {
            case .success(let response):
                self.categoryInfoList = response
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchResult(searchValue: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let api = SharedManager.shared.currentAPI
        let baseURL = "\(api)?title_contains=\(searchValue)"
        fetchResult(url: baseURL, completion: completion)
    }
    
    func fetchMoreDetails(url: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        fetchResult(url: url, completion: completion)
    }
    
    func fetchResult(url: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        APIHandler().fetchDetails(baseURL: url) { (result: Result<NewsList, Error>) in
            switch result {
            case .success(let response):
                self.newsList = response
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getResults() -> [Results]? {
        selectedCategory != nil ? newsList?.results?.filter({ $0.news_site == selectedCategory }) : newsList?.results
    }
    
    func getCategoryList() -> [String]? {
        ["All"] + (categoryInfoList?.news_sites ?? [])
    }
    
    func selectCategory(name: String?) {
        selectedCategory = name
    }
}




