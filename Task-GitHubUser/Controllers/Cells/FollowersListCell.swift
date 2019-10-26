//
//  FollowersListCell.swift
//  Task-GitHubUser
//
//  Created by Rahul Nimje on 25/10/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

class FollowersListCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       imageUser.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
