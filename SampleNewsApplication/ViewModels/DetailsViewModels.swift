//
//  DetailsViewModels.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 11/02/25.
//
import Foundation
import UIKit

class DetailsViewModels {
    func fetchNewsDetails(id: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        let baseURL = "\(SharedManager.shared.currentAPI)\(id)/"
        APIHandler().fetchDetails(baseURL: baseURL, completion: completion)
    }
}
