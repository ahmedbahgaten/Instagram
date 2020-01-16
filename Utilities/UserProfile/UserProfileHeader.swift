//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
class UserProfileHeader:UICollectionViewCell {
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, paddingTop: 12, height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 
