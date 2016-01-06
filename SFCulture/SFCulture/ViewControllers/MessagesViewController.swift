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
import RealmSwift

class MessagesViewController: JSQMessagesViewController {
    
    let messagesImageFactory = JSQMessagesBubbleImageFactory()
    let realm = try! Realm()
    
    var messages = [JSQMessage]()
    var avatars = Dictionary<String, JSQMessagesAvatarImage>()
    var outgoingBubbleImage: JSQMessagesBubbleImage!
    var incomingBubbleImage: JSQMessagesBubbleImage!
    
    var senderImageUrl: String!
    var batchMessages = true
    
    var ref: Firebase!
    var messagesRef: Firebase!
    var currentMessageGroupId: String!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMessageGroupId = realm.objects(currentMessageGroup)[0].messageGroup!.id
        user = realm.objects(currentUser)[0].user
        
        messagesRef = Firebase(url: "https://sfculture.firebaseio.com/messageGroups/" + currentMessageGroupId)

        outgoingBubbleImage = messagesImageFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        incomingBubbleImage = messagesImageFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        
        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true
        
        // Set up user through the cached one here!
//        let profileImageUrl = user?.providerData["cachedUserProfile"]?["profile_image_url_https"] as? NSString
//        if let urlString = profileImageUrl {
//            setupAvatarImage(sender, imageUrl: urlString as String, incoming: false)
//            senderImageUrl = urlString as String
//        } else {
//            setupAvatarColor(sender, incoming: false)
//            senderImageUrl = ""
//        }
        
        observeMessages() // Need to think about the chat room itself, change up the endpoint
        
    }
    
    func observeMessages() {
        
        
        messagesRef.queryLimitedToLast(25).observeEventType(FEventType.ChildAdded, withBlock: {
            (snapshot) in
            let senderId = snapshot.valueForKey("senderId") as! String
            let senderDisplayName = snapshot.valueForKey("senderDisplayName") as! String
            let date = snapshot.valueForKey("date") as! NSDate // Need to convert this later
            let text = snapshot.valueForKey("text") as! String
            
            let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
            self.messages.append(message)
            self.finishReceivingMessage()
            
            
        })
    }
    
    func sendMessage(senderId: String, senderDisplayName: String, date: String, text: String) {
        messagesRef.childByAutoId().setValue([
            "senderId": senderId,
            "senderDisplayName": senderDisplayName,
            "date": date,
            "text": text
            ])
    }
    
    func sendMessageUIPlaceholder(senderId: String, senderDisplayName: String, date: NSDate, text: String) {
        let tempMessage = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        messages.append(tempMessage)
        
    }
    
    func setupAvatarImage(name: String, imageUrl: String?, incoming: Bool) {
        if let stringUrl = imageUrl {
            if let url = NSURL(string: stringUrl) {
                if let data = NSData(contentsOfURL: url) {
                    let image = UIImage(data: data)
                    let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
                    let avatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(image, diameter: diameter)
                    avatars[name] = avatarImage
                    return
                }
            }
        }
        setupAvatarColor(name, incoming: incoming)
    }
    
    func setupAvatarColor(name: String, incoming: Bool) {
        let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let rgbValue = name.hash
        let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
        let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        let b = CGFloat(Float(rgbValue & 0xFF)/255.0)
        let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
        
        let initials = name.componentsSeparatedByString(" ")
        let userImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials[0] + initials[1], backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(CGFloat(13)), diameter: diameter)
        
        avatars[name] = userImage
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.collectionViewLayout.springinessEnabled = true
    }
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        // Simulate reciving message
        showTypingIndicator = !showTypingIndicator
        scrollToBottomAnimated(true)
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        sendMessage(senderId, senderDisplayName: senderDisplayName, date: getCurrentDateAsString(), text: text)
        
        finishSendingMessage()
    }
    
    func getCurrentDateAsString() -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return formatter.stringFromDate(NSDate())
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("Camera pressed!")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId() == user.uid {
            return outgoingBubbleImage
        }
        return incomingBubbleImage
    }
    
//    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//        let message = messages[indexPath.item]
//    }

}
