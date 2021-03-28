//
//  albumViewCell.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 15.03.2021.
//

import UIKit

class albumViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(with label: String, and image: UIImage) {
        labelView.text = label
        imageView.image = image
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

