//
//  Posts.swift
//  Instagram
//
//  Created by AHMED on 2/3/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation

struct Post {
    let imageURL:String?
    let user:User
    let caption:String?
    init(user:User,dictionary:[String:Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
struct User {
    let username:String
    let profileImageUrl:String
    init(dictionary:[String:Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
        
    }
}
