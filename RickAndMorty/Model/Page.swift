//
//  Page.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation

// Contains the results from our webrequest
// conforms to decodable to for us to easily populate object
class Page: Decodable {
    var info: Info
    var results: [Person]
    
    init(info: Info, results: [Person]) {
        self.info = info
        self.results = results
    }
}

//conatins next and prev pages will be used for coninuous scrolling
struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
