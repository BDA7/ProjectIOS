//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 07.03.2021.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! albumViewCell
        let album = searchResponse?.results[indexPath.row]
        let url = URL(string: (album!.artworkUrl100))
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() {    // execute on main thread
                cell.imageView!.image = UIImage(data: data)
            }
        }.resume()

        
        cell.labelView?.text = album?.collectionName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
    }
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    let network = Network()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        collectionSetup()

        
    }
    func collectionSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib.init(nibName: "albumViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=album"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
            self.network.request(urlString: urlString) { [weak self] (result) in
                
                switch result {
                
                case .success(let searchResponse):
                    self?.searchResponse = searchResponse
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
        
    }
}


