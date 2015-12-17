//
//  User.swift
//  SFCulture
//
//  Created by Jimmy Yue on 11/27/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import Gloss

struct UserJSON: Glossy {
    
    let uid: String?
    let name: String?
    let profilePicture: String?
    let culture: String?
    
    
    init(uid: String, name: String, profilePicture: String, culture: String) {
        self.uid = uid
        self.name = name
        self.profilePicture = profilePicture
        self.culture = culture
    }
    
    init?(json: JSON) {
        self.uid = "uid" <~~ json
        self.name = "name" <~~ json
        self.profilePicture = "profilePicture" <~~ json
        self.culture = "culture" <~~ json

    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "uid" ~~> self.uid,
            "name" ~~> self.name,
            "profilePic" ~~> self.profilePicture,
            "culture" ~~> self.culture,
            ])
    }
    
}
