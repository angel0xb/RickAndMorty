//
//  ListViewModel.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation
import Combine

//View Model for our View controller

class ListViewModel {
    //Create a publisher for our people array
    @Published var people: [Person] = []
    let netManager = NetworkManager()
    
    init() {
        getPeople()
    }
    
    /// Retrieves initial characters data
    func getPeople() {
        
        //Use our network manager to retrieve our results
        netManager.retrieveResults { result in
            switch result {
            //On success we will update our people array
            case .success(let people):
                guard let people = people else { return }
                self.people = people
            case.failure(let error):
                //for now we are just printing our error
                //will want to display this to user in future
                print(error)
            }
        }
    }
    
    /// Loads next page of characters
    func loadNext() {
        netManager.loadNextPage { result in
            switch result {
            case .success(let people):
                guard let people = people else { return }
                //add to our current people
                self.people.append(contentsOf:people)
            case.failure(let error):
                //for now we are just printing our error
                //will want to display this to user in future
                print(error)
            }
        }
    }
}
