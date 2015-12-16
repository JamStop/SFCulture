//
//  Realm.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/16/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import RealmSwift
import JSQMessagesViewController


class User: Object {
    dynamic var uid = ""
    dynamic var name = ""
    dynamic var profilePicture: NSData?
    dynamic var culture: Culture?
    dynamic var messageGroups: [MessageGroup] = []
    
}

class Culture: Object {
    dynamic var name = ""
    dynamic var members: [User] = []
    
}

class MessageGroup: Object {
    dynamic var id = ""
    dynamic var messages: [Message] = []
    dynamic var users: [User] = []
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
