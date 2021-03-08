//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 07.03.2021.
//

import UIKit

struct giveAlbum: Decodable {
    var collectionName: String
}


class ViewController: UIViewController {
    
    let network = Network()
    
    var searchResponse: SearchResponse? = nil
    
    @IBOutlet weak var searchAlbum: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=3"
        network.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let searchResponse):
                searchResponse.results.map { (album) in
                    self.searchResponse = searchResponse
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
    


