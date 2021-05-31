//
//  PostDetailCollectionViewCell.swift
//  IG
//
//  Created by Yang Nina on 2021/5/28.
//

import UIKit

class PostDetailCollectionViewCell: UICollectionViewCell {
    var likeStatus:Bool = false
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userAccountLabel: UILabel!
    @IBOutlet weak var userPostImg: UIImageView!
    @IBOutlet weak var likecountLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBAction func likeClick(_ sender: UIButton) {
        likeStatus = !likeStatus //true
        if likeStatus{
            likeBtn.setImage(UIImage(named: "heartred"), for: UIControl.State.normal)
        }
        else{
            likeBtn.setImage(UIImage(named: "heart"), for: UIControl.State.normal)
        }
    }
}
