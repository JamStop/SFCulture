//
//  FirebaseMessageHelper.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/4/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

var messagesRef: Firebase!

class FirebaseMessageHelper {
    func setup() {
        messagesRef = Firebase(url: "https://sfculture.firebaseio.com/messages")
        
        
        messagesRef.queryLimitedToLast(25).observeEventType(FEventType.ChildAdded, withBlock: {
            (snapshot) in
            let senderId = snapshot.valueForKey("senderId") as? String
            let senderDisplayName = snapshot.valueForKey("senderDisplayName") as? String
            let date = snapshot.valueForKey("date") as? String
            let isMediaMessage = snapshot.valueForKey("isMediaMessage") as? String
            let messageHash = snapshot.valueForKey("messageHash")
            let text = snapshot.valueForKey("text")
            let image = snapshot.valueForKey("image")
            
            let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, isMediaMessage: isMediaMessage, messageHash: <#T##UInt#>, text: <#T##String#>, image: <#T##String#>)
            
            
            })
        messagesRef.queryLimitedToNumberOfChildren(25).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
            let text = snapshot.value["text"] as? String
            let sender = snapshot.value["sender"] as? String
            let imageUrl = snapshot.value["imageUrl"] as? String
            
            let message = Message(text: text, sender: sender, imageUrl: imageUrl)
            self.messages.append(message)
            self.finishReceivingMessage()
        })
    }
    
    
}