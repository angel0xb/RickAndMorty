//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation
import UIKit

// This class is in charge of all of our network requests
class NetworkManager {
    
    
    /// Makes initial request for characters
    /// - Parameter completion: Gives us a result with  and array of Person if successful or and error if failure
    func retrieveResults(completion: @escaping (Result<[Person]?,Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    //maake use of json decoder to get our results
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
    
    /// Makes a reuqest using a urlString to get our image
    /// - Parameters:
    ///   - urlString: url string used to make request
    ///   - completion: Result with UIImage if successul and and error if failure
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
