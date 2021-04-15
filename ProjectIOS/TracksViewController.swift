//
//  TracksViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 31.03.2021.
//

import UIKit

class TracksViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var albumname: UILabel!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var typeAlbum: UILabel!

    var name = 1
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
        setupAlbum()

    }

}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
// Определение таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackResponse?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltable", for: indexPath)
        let track = trackResponse?.results[indexPath.row]
        if let nameTrack = track?.trackName {
            cell.textLabel?.text = "\(indexPath.row+1)    " + nameTrack
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = .white
        }
        return cell
    }
// получение данных для таблицы
    func netTrack() {
        urlString = "https://itunes.apple.com/lookup?id=\(name)&entity=song"
        network.requestTracks(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let trackResponse):
                self?.trackResponse = trackResponse
                self?.table.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
// Создание образа таблицы
    func setupTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "celltable")
        table.delegate = self
        table.dataSource = self
    }
// установка данных о албоме
    func setupAlbum() {
        albumname.text = alnname
        nameArtist.text = nameArt
        typeAlbum.text = type
        imageAlbum.load(link: imgname)
        imageAlbum.layer.cornerRadius = 10
    }
}
