//
//  Network.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 15.03.2021.
//

import Foundation
import UIKit

class Network {
    func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let albums = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(albums))
                } catch  let jsonError {
                    print("Faled Decode \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    func getImage(album:Album, imagine: @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: (album.artworkUrl100))
        URLSession.shared.dataTask(with: url!) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return }
                guard let image = UIImage(data: data) else { return }
                imagine(.success(image))
            }
        }.resume()
    }
    func requestTracks(urlString: String, completion: @escaping (Result<TrackResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let tracks = try JSONDecoder().decode(TrackResponse.self, from: data)
                    completion(.success(tracks))
                } catch  let jsonError {
                    print("Faled Decode \(jsonError)")
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
