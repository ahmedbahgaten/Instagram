//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeader:UICollectionViewCell {
 
    var user:User? {
            didSet {
                setupProfileImage()
                usernameLabel.text = user?.username
            }
        }
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    let gridButton :UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    let listButton :UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)

          return button
    }()
    let bookMarkButton :UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)

          return button
    }()
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let postsLabel :UILabel = {
       let label = UILabel()
        let font = UIFont.boldSystemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "11\n",attributes:[NSAttributedString.Key.font:font])
        attributedText .append(NSAttributedString(string:"posts",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.font:font]))
        label.attributedText = attributedText

        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let followersLabel :UILabel = {
        let label = UILabel()
        let font = UIFont.boldSystemFont(ofSize: 14)
           let attributedText = NSMutableAttributedString(string: "11\n",attributes:[NSAttributedString.Key.font:font])
           attributedText .append(NSAttributedString(string:"followers",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.font:font]))
           label.attributedText = attributedText
        label.numberOfLines = 0
         label.textAlignment = .center
         return label
     }()
    let followingLabel :UILabel = {
        let label = UILabel()
        let font = UIFont.boldSystemFont(ofSize: 14)
           let attributedText = NSMutableAttributedString(string: "11\n",attributes:[NSAttributedString.Key.font:font])
           attributedText .append(NSAttributedString(string:"followers",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.font:font]))
           label.attributedText = attributedText
        label.numberOfLines = 0
         label.textAlignment = .center
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, paddingTop: 12, height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80/2
             profileImageView.clipsToBounds = true
        setupBottomToolBar()

        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: gridButton.topAnchor, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, paddingTop: 4, height: 0, width: 0)
     
        setupUsereStatsView()
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, right: followingLabel.rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 2, height: 34, width: 0)
    }
    fileprivate func setupUsereStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, paddingTop: 12, height: 50, width: 0)
    }
    fileprivate func setupBottomToolBar() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
           bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView.init(arrangedSubviews: [gridButton,listButton,bookMarkButton])
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: nil, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 50, width: 0)
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 0.5, width: 0)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, paddingTop: 0, height: 0.5, width: 0)
    }
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else {return }
        guard let url = URL(string: profileImageUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("There is something went wrong",err)
            }
            print(data ?? "")
            guard let data = data else {return}
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

