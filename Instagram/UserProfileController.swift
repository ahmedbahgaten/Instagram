//
//  UserProfileController.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController:UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        fetchUser()
    }
    fileprivate func fetchUser () {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            let dictionary = snapshot.value as? [String:Any]
            let username = dictionary?["username"] as? String
            self.navigationItem.title = username
        }) { (err) in
            print("Failed to fetch",err)
        }
    }
}
