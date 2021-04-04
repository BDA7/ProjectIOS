//
//  TrackResponse.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 03.04.2021.
//

import Foundation

struct TrackResponse: Decodable {
    var resultCount: Int
    var results: [Tracks]
}

struct Tracks: Decodable {
    var trackName: String?
    var artworkUrl100: String
}
