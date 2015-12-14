//
//  User.swift
//  SFCulture
//
//  Created by Jimmy Yue on 11/27/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import Gloss

struct User: Glossy {
    
    let email: String?
    let password: String?
    let username: String?
    let identifier: String?
    let followerCount: Int?
    let followingCount: Int?
    let userType: String?
    
    
    init(email: String, password: String, username: String, userType: String) {
        self.email = email
        self.password = password
        self.username = username
        self.identifier = nil
        self.followerCount = nil
        self.followingCount = nil
        self.userType = userType
    }
    
    init?(json: JSON) {
        self.email = "email" <~~ json
        self.password = "password" <~~ json
        self.username = "username" <~~ json
        self.identifier = "identifier" <~~ json
        self.followerCount = "followercount" <~~ json
        self.followingCount = "followingcount" <~~ json
        self.userType = "usertype" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "email" ~~> self.email,
            "password" ~~> self.password,
            "username" ~~> self.username,
            "identifier" ~~> self.identifier,
            "followercount" ~~> self.followerCount,
            "followingcount" ~~> self.followingCount,
            "usertype" ~~> self.userType
            ])
    }
    
}
