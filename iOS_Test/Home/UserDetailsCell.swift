//
//  UserDetailsCell.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit

class UserDetailsCell: UITableViewCell {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var nationalityLabel: UILabel!
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
