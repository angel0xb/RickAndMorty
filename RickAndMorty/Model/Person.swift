//
//  Person.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation

//Model for the the Characters we retrieve from the results of our Page
class Person: Decodable {
    var name: String
    var status: String
    var species: String
    var imageURL: String
    var location: Location
    
    init(name: String, status: String, species: String, imageURL: String, location: Location) {
        self.name = name
        self.status = status
        self.species = species
        self.imageURL = imageURL
        self.location = location
    }
    
    //Using Coding keys because 'image' is technically the url for the image
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case species
        case imageURL = "image"
        case location
    }
}

struct Location: Decodable {
    var name: String
    var url: String
}
