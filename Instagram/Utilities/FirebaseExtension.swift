//
//  Firebase Utils.swift
//  Instagram
//
//  Created by AHMED on 2/7/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import Firebase
extension Database {
    static func fetchUserWithUID(uid:String,completion: @escaping (User) -> ()) {
        print("Fetching user with uid:",uid)
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String:Any] else {return}
            let user = User(uid:uid,dictionary: userDictionary)
            print(user.username)
            completion(user)
        }) { (err) in
            print("Failed to fetch user for posts ",err)
        }
    }
}
