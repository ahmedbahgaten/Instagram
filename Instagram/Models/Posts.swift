//
//  Posts.swift
//  Instagram
//
//  Created by AHMED on 2/3/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation

struct Post {
    var id:String?
    let imageURL:String?
    let user:User
    let caption:String?
    let creationDate:Date
    var hasLiked:Bool = true
    init(user:User,dictionary:[String:Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}

