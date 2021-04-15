//
//  ViewController.swift
//  ProjectIOS
//  Created by Александр Хижко on 07.03.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    let network = Network()
    var searchResponse: SearchResponse?
    var urlString = ""
    var rowselected = 0
    var img: UIImage?
    var vm = VModel()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        collectionSetup()

    }
// Определение коллекции
    func collectionSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "AlbumViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
// Определение SearchBar
    func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
// Создание запроса
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        let stx = searchText.replacingOccurrences(of: " ", with: "")
        urlString = "https://itunes.apple.com/search?term=\(stx)&entity=album"
    }
// Получение данных по запросу
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        network.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searchResponse = searchResponse
                self?.vm.searchResponse = searchResponse
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension ViewController {
// Создание образа коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumViewCell
        let album = vm.searchResponse?.results[indexPath.row]
        cell.imageView.load(link: album?.artworkUrl100)
        cell.labelView?.text = album?.collectionName
        return cell
    }
// Передача данных на второй экран
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "firstSegue", sender: self)
        rowselected = indexPath.row
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
            guard let destination1 = segue.destination as? TracksViewController else { return }
            if let path = collectionView.indexPathsForSelectedItems {
                let row = path[0].row
                if searchResponse?.results[row].collectionId != nil && searchResponse?.results[row].artworkUrl100 != nil && searchResponse?.results[row].collectionName != nil {
                    destination1.name = (searchResponse?.results[row].collectionId)!
                    destination1.imgname = (searchResponse?.results[row].artworkUrl100)!
                    destination1.alnname = (searchResponse?.results[row].collectionName)!
                    destination1.nameArt = (searchResponse?.results[row].artistName)!
                    destination1.type = (searchResponse?.results[row].primaryGenreName)!
                }
            }
        }
    }
}
