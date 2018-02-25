//
//  FeedGroupCell.swift
//  breakpoint
//
//  Created by Robihamanto on 23/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class FeedGroupCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    func configureCell (forString image: UIImage, forEmail email: String, andMessage message: String) {
        self.profileImage.image = image
        self.emailLabel.text = email
        self.messageLabel.text = message
    }
    
}
