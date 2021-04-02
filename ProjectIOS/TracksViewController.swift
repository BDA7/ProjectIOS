//
//  TracksViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 31.03.2021.
//

import UIKit

class TracksViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltable", for: indexPath)
        cell.textLabel?.text = name
        return cell
    }
}
