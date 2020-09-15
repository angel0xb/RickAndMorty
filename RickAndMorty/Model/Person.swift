//
//  Person.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation

class Person: Decodable {
    var name: String
    var status: String
    var species: String
    var image: String
    
    init(name: String, status: String, species: String, image: String) {
        self.name = name
        self.status = status
        self.species = species
        self.image = image
    }
}
