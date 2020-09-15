//
//  ListViewModel.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation
import Combine

class ListViewModel {
    @Published var people: [Person] = []
    
    init() {
        getPeople()
    }
    
    func getPeople() {
        let netManager = NetworkManager()
        netManager.retrieveResults { result in
            switch result {
            case .success(let people):
                guard let people = people else { return }
                self.people = people
            case.failure(let error):
                print(error)
            }
        }
    }
}
