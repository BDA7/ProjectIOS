//
//  TracksViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 31.03.2021.
//

import UIKit

class TracksViewController: UIViewController {
    @IBOutlet weak var tableViewTracks: UITableView!

    var albumID = 1
    var urlString = ""
    var trackResponse: TrackResponse?
    let network = Network()
    var imgname = ""
    var alnname = ""
    var nameArt = ""
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        netTrack()
        setupTable()

    }

}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
// Определение таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackResponse?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTracks.dequeueReusableCell(withIdentifier: "tracksViewCell", for: indexPath) as! TracksTableViewCell
        cell.nameOfAlbum.text = "1234567890"
        cell.nameOfAlbum.backgroundColor = .yellow
        return cell
    }
// получение данных для таблицы
    func netTrack() {
        urlString = "https://itunes.apple.com/lookup?id=\(albumID)&entity=song"
        network.requestTracks(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let trackResponse):
                self?.trackResponse = trackResponse
                self?.tableViewTracks.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
// Создание образа таблицы
    func setupTable() {
//        tableViewTracks.register(UITableViewCell.self, forCellReuseIdentifier: "celltable")
        tableViewTracks.register(UINib.init(nibName: "TracksTableViewCell", bundle: nil), forCellReuseIdentifier: "tracksViewCell")
        tableViewTracks.delegate = self
        tableViewTracks.dataSource = self
        tableViewTracks.allowsSelection = false
        tableViewTracks.tableFooterView = UIView()
    }
}
