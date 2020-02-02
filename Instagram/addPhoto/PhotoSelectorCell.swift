//
//  PhotoSelectorCell.swift
//  Instagram
//
//  Created by AHMED on 2/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
class PhotoSelectorCell : UICollectionViewCell {
    let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    override init (frame:CGRect) {
        super.init(frame:frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 0, width: 0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
