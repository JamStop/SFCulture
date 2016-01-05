//
//  MessagesViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/3/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class MessagesViewController: JSQMessagesViewController {
    
    let messagesImageFactory = JSQMessagesBubbleImageFactory()
    
    var messages = [JSQMessage]()
    var avatars = Dictionary<String, UIImage>()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    var senderImageUrl: String!
    var batchMessages = true
    
    var ref: Firebase!
    var messagesRef: Firebase!

    override func viewDidLoad() {
        super.viewDidLoad()

        outgoingBubbleImageView = messagesImageFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        incomingBubbleImageView = messagesImageFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        
    }
    
    func observeMessages() {
        messagesRef = Firebase(url: "https://sfculture.firebaseio.com/messages")
        
        
        messagesRef.queryLimitedToLast(25).observeEventType(FEventType.ChildAdded, withBlock: {
            (snapshot) in
            let senderId = snapshot.valueForKey("senderId") as! String
            let senderDisplayName = snapshot.valueForKey("senderDisplayName") as! String
            let date = snapshot.valueForKey("date") as! NSDate // Need to convert this later
            let text = snapshot.valueForKey("text") as! String
            let image = snapshot.valueForKey("image") as! String
            
            let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text, image: image)
            self.messages.append(message)
            self.finishReceivingMessage()
            
            
        })
    }
    
    func sendMessage(senderId: String, senderDisplayName: String, date: String, text: String, image: String) {
        messagesRef.childByAutoId().setValue([
            "senderId": senderId,
            "senderDisplayName": senderDisplayName,
            "date": date,
            "text": text,
            "image": image
            ])
    }
    
    func sendMessageUIPlaceholder(senderId: String, senderDisplayName: String, date: NSDate, text: String, image: UIImage) {
        let tempMessage = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text, image: image)
    }


}
