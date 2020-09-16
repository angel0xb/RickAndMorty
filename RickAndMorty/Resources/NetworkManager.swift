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
    //keeps track of which page we are on
    var info: Info?
    
    /// Makes initial request for characters
    /// - Parameter completion: Gives us a result with  and array of Person if successful or and error if failure
    func retrieveResults(completion: @escaping (Result<[Person]?,Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    //maake use of json decoder to get our results
                    let decoder = JSONDecoder()
                    let page = try? decoder.decode(Page.self, from: data)
                    self.info = page?.info//update our info
                    if let persons = page?.results {
                        completion(.success(persons))
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    //Loads our next batch of characters using our info object
    func loadNextPage(completion: @escaping (Result<[Person]?,Error>) -> Void) {
        guard let info = info, let nextPage = info.next else { return }
        let url = URL(string: nextPage)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    //maake use of json decoder to get our results
                    let decoder = JSONDecoder()
                    let page = try? decoder.decode(Page.self, from: data)
                    self.info = page?.info//update info
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
