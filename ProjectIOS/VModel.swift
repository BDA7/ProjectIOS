//
//  VModel.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 10.04.2021.
//

import Foundation

class VModel {
    var searchResponse: SearchResponse?
    let network = Network()
    var urlString = ""
    var album: Album?

    func giveElements(idx: Int) -> Album? {
        let album = searchResponse?.results[idx]
        return album
    }
}
