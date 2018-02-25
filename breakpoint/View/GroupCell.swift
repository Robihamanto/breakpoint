//
//  GroupCell.swift
//  breakpoint
//
//  Created by Robihamanto on 23/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var groupMemberLabel: UILabel!
    
    func configureCell(forTitle title: String, forDescription desc: String, andMember member: Int) {
        self.titleLabel.text = title
        self.descLabel.text = desc
        self.groupMemberLabel.text = "\(member) member"
    }

}
