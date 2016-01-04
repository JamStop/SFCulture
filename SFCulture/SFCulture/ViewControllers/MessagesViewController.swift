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


}
