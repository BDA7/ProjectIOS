//
//  SearchResponse.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 14.03.2021.
//

import Foundation
import UIKit

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Album]
}

struct Album: Decodable {
    var collectionName: String
    var artworkUrl100: String
}
