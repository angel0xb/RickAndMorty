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
    
    init() {
        getPeople()
    }
    
    /// Retrieves initial characters data
    func getPeople() {
        let netManager = NetworkManager()
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
}
