//
//  FirebaseMessageHelper.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/4/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

//import Foundation
//import RxSwift
//import Firebase
//
//var messagesRef: Firebase!
//
//class FirebaseMessageHelper {
//    func observeMessages() {
//        messagesRef = Firebase(url: "https://sfculture.firebaseio.com/messages")
//        
//        
//        messagesRef.queryLimitedToLast(25).observeEventType(FEventType.ChildAdded, withBlock: {
//            (snapshot) in
//            let senderId = snapshot.valueForKey("senderId") as! String
//            let senderDisplayName = snapshot.valueForKey("senderDisplayName") as! String
//            let date = snapshot.valueForKey("date") as! NSDate // Need to convert this later
//            let text = snapshot.valueForKey("text") as! String
//            let image = snapshot.valueForKey("image") as! String
//            
//            let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text, image: image)
//            self.messages.append(message)
//            
//            
//            
//            })
//        messagesRef.queryLimitedToNumberOfChildren(25).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
//            let text = snapshot.value["text"] as? String
//            let sender = snapshot.value["sender"] as? String
//            let imageUrl = snapshot.value["imageUrl"] as? String
//            
//            let message = Message(text: text, sender: sender, imageUrl: imageUrl)
//            self.messages.append(message)
//            self.finishReceivingMessage()
//        })
//    }
//
//    
//}