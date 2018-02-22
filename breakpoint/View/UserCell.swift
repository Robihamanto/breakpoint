//
//  UserCell.swift
//  breakpoint
//
//  Created by Robihamanto on 18/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var isCheckedImage: UIImageView!
    var showing = false
    
    func cofigureCell(forImageName image: String, userEmail email: String, andIsChecked isSelected: Bool) {
        self.profileImage.image = UIImage(named: image)
        self.emailLabel.text = email
        self.isCheckedImage.isHidden = isSelected ? false : true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if !showing {
                isCheckedImage.isHidden = false
                showing = true
            } else {
                isCheckedImage.isHidden = true
                showing = false
            }
        }
    }

}
