//
//  Page.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import Foundation

struct Info: Decodable {
    var count: Int
     var pages: Int
     var next: String?
     var prev: String?
}
class Page: Decodable {
    var info: Info
    var results: [Person]
    
    init(info: Info, results: [Person]) {
        self.info = info
        self.results = results
    }
}
