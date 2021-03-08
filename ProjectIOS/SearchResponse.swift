//
//  SearchResponse.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 08.03.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Album]
}


struct Album: Decodable {
    var artistName: String
    var collectionName: String
    var artworkUrl100: String?
}
