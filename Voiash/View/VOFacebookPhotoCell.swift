//
//  VOFacebookPhotoCell.swift
//  Voiash
//
//  Created by Brenda Saavedra on 10/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit

class VOFacebookPhotoCell: UITableViewCell {

    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.backgroundColor = .clear
    }

}
