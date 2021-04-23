//
//  TableViewCell.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 18.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfAlbum: UIImageView!
    @IBOutlet weak var nameOfAlbum: UILabel!
    @IBOutlet weak var nameOfArtist: UILabel!
    @IBOutlet weak var styleSong: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initialize(with name: String, and image: UIImage, and arName: String, and style: String) {
        nameOfArtist.text = name
        imageOfAlbum.image = image
        nameOfArtist.text = arName
        styleSong.text = style
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
