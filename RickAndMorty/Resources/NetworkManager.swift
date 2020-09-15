//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    func retrieveResults(completion: @escaping (Result<[Person]?,Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    let page = try? decoder.decode(Page.self, from: data)
                    
                    if let persons = page?.results {
                        completion(.success(persons))
                    }
                    
                }
            }
        }
         task.resume()
    }
    
    func getImage(for urlString: String, completion: @escaping (Result<UIImage?,Error>)->()) {
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    }
                    
                }
            }
        }
        task.resume()
    }
    
}
