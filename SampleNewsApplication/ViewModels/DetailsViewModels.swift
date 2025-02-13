//
//  DetailsViewModels.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 11/02/25.
//
import Foundation
import UIKit

class DetailsViewModels {
    
    var currentID: Int?
    var results: Results? = nil
    
    func fetchNewsDetails(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let baseURL = "\(SharedManager.shared.currentAPI)\(id)/"
        APIHandler().fetchDetails(baseURL: baseURL) { (result: Result<Results, Error>) in
            switch result {
            case .success(let articles):
                self.results = articles
                self.currentID = id
                completion(.success(true))
            case .failure(let error):
                print("Error fetching articles: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func nextPage(completion: @escaping (Result<Bool, Error>) -> Void) {
       let id = (currentID ?? 0) + 1
        fetchNewsDetails(id: id, completion: completion)
    }
    
    func previousPage(completion: @escaping (Result<Bool, Error>) -> Void) {
        let id = (currentID ?? 0) - 1
        fetchNewsDetails(id: id, completion: completion)
    }
}
