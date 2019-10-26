//
//  ExImageView.swift
//  Task-GitHubUser
//
//  Created by Rahul Nimje on 26/10/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
