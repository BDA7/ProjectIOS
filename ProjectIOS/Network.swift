//
//  Network.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 08.03.2021.
//

import Foundation

class Network {
    func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                let someString = String(data: data, encoding: .utf8)
                print(someString ?? "no data")
                do{
                    let albums = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(albums))
                } catch let jsonError {
                    print("Error: ", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
