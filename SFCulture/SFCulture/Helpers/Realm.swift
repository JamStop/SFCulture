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
    dynamic var profilePicture: NSData?
    dynamic var profilePictureURL: String?
    dynamic var culture: Culture?
    let messageGroups = List<MessageGroup>()
    
}

class CurrentUser: Object {
    dynamic var user: User?
    dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CurrentMessageGroup: Object {
    dynamic var messageGroup: MessageGroup?
    dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Culture: Object {
    dynamic var name = ""
    dynamic var members: [User] {
        return linkingObjects(User.self, forProperty: "culture")
    }
    dynamic var messageGroups: [MessageGroup] {
        return linkingObjects(MessageGroup.self, forProperty: "culture")
    }
    
}

class MessageGroup: Object {
    dynamic var id = ""
    dynamic var culture: Culture?
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
//    dynamic var messageHash: UInt = 0
    dynamic var text = ""
    dynamic var messageGroup: MessageGroup?
}
