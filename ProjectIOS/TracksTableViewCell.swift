//
//  TracksTableViewCell.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 20.04.2021.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfAlbum: UIImageView!
    @IBOutlet weak var nameOfAlbum: UILabel!
    @IBOutlet weak var nameOfArtist: UILabel!
    @IBOutlet weak var styleTrack: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
