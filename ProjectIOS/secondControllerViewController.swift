//
//  secondControllerViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 08.03.2021.
//

import UIKit




class secondControllerViewController: UIViewController {
    
    let network = Network()

    var searchResponse: SearchResponse? = nil

    struct giveAlbum: Decodable {
        var collectionName: String
    }
    
    @IBOutlet weak var collection: UICollectionView!
    
    var textFromVC: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = textFromVC
        let urlString = "https://itunes.apple.com/search?term=\(textFromVC)&entity=album&limit=3"
        network.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let searchResponse):
                searchResponse.results.map { (album) in
                    self.searchResponse = searchResponse
                    print(album.collectionName)
                }
            case .failure(let error):
                print(error)
            }
        }

    }

}

    
    

