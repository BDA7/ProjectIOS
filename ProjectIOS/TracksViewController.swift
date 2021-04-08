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
    var name = 1
    var urlString = ""
    var trackResponse: TrackResponse?
    let network = Network()
    var imgname = ""
    var alnname = ""
    var img: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        netTrack()
        setupTable()
        network.getImage(urlstr: imgname) { (result) in
            switch result {
            case .success(let img):
                self.img = img
                self.imageAlbum.image = img
            case .failure(let error):
                print(error)
            }
            self.albumname.text = self.alnname
        }
    }
    func setupTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "celltable")
        table.delegate = self
        table.dataSource = self
    }

}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackResponse?.results.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltable", for: indexPath)
        let track = trackResponse?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        cell.imageView?.image = img!
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = .white
        return cell
    }
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
}
