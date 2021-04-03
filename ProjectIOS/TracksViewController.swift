//
//  TracksViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 31.03.2021.
//

import UIKit

class TracksViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var name = 1
    var urlString = ""
    var trackResponse: TrackResponse?
    let network = Network()
    override func viewDidLoad() {
        super.viewDidLoad()
        netTrack()
        setupTable()
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
        return cell
    }
    func netTrack() {
        urlString = "https://itunes.apple.com/search?term=\(name)&entity=album"
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
