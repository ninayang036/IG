//
//  ProfileCollectionReusableView.swift
//  IG
//
//  Created by Yang Nina on 2021/5/24.
//

import UIKit

class ProfileCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headshotImg: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    
    @IBOutlet var Buttons: [UIButton]!
}
