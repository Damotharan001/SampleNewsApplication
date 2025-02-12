//
//  APIHandler.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 11/02/25.
//
import Foundation
import UIKit

class APIHandler {
    func fetchDetails<T: Decodable>(baseURL: String , completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


