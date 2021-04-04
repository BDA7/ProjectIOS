//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 07.03.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumViewCell
        let album = searchResponse?.results[indexPath.row]

        network.getImage(album: album!) { (result) in
            switch result {

            case .success(let imagine):
                cell.imageView.image = imagine
                self.img = imagine
            case .failure(let error):
                print(error)
            }
        }
        cell.labelView?.text = album?.collectionName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "firstSegue", sender: collectionView.cellForItem(at: indexPath))
        rowselected = indexPath.row
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
            guard let destination1 = segue.destination as? TracksViewController else { return }
            destination1.name = (searchResponse?.results[rowselected].collectionId)!
            destination1.img = img!
            
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    let network = Network()
    var searchResponse: SearchResponse?
    var urlString = ""
    var rowselected = 0
    var img: UIImage?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        collectionSetup()

    }

    func collectionSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "AlbumViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }

    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=album"
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        network.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searchResponse = searchResponse
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
