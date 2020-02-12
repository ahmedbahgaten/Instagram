//
//  Comments.swift
//  Instagram
//
//  Created by AHMED on 2/11/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
struct Comment {
    let user:User
    let text:String
    let uid:String
    init(user:User,dictionary:[String:Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String  ?? ""
        self.user = user
    }
}
