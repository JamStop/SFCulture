//
//  Realm.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/16/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var uid = ""
    dynamic var name = ""
    dynamic var profilePicture = ""
    dynamic var culture: Culture?
    dynamic var messageGroups: [MessageGroup] = []
    
}

class currentUser: Object {
    dynamic var user: User?
}

class Culture: Object {
    dynamic var name = ""
    dynamic var culturePicture = ""
    dynamic var members: [User] {
        return linkingObjects(User.self, forProperty: "messageGroups")
    }
    
}

class MessageGroup: Object {
    dynamic var id = ""
    dynamic var messages: [Message] {
        return linkingObjects(Message.self, forProperty: "messageGroup")
    }
    dynamic var users: [User] {
        return linkingObjects(User.self, forProperty: "")
    }
}

class Message: Object {
    dynamic var senderId = ""
    dynamic var senderDisplayName = ""
    dynamic var date = NSDate(timeIntervalSince1970: 1)
    dynamic var isMediaMessage = false
    dynamic var messageHash: UInt = 0
    dynamic var text = ""
    dynamic var messageGroup: MessageGroup?
}
