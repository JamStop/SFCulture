//
//  FirebaseLogin.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/11/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FBSDKLoginKit
import RealmSwift
import SDWebImage


class FirebaseLoginHelper {
    var ref: Firebase!
    
    let facebookLogin = FBSDKLoginManager()
    
    let realm = try! Realm()
    let imageDownloader = SDWebImageDownloader()

    func login(viewController: UIViewController, completion: (Bool) -> Void) {
        ref = Firebase(url: "https://sfculture.firebaseio.com/")
        
        facebookLogin.logInWithReadPermissions(["public_profile", "user_friends", "email"], fromViewController: viewController, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
//                completion(false)
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
                completion(false)
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print(facebookResult)
                self.ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                            completion(false)
                            return
                        } else {
                            print("Logged in! \(authData)")
                            print(authData.provider)
                            self.getFBUserData(completion)
                        }
                })
            }
        })
    }
    
    
    func getFBUserData(completion: (Bool) -> Void) {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error != nil {
                    completion(false)
                }
                else {
                    let userData : NSDictionary = result as! NSDictionary
                    let uid = userData["id"] as! String
                    
                    var pictureURL: String?
                    
                    if let picture = userData["picture"] as? NSDictionary {
                        if let data = picture["data"] as? NSDictionary {
                            pictureURL = data["url"] as? String
                        }
                    }
                    
                    print(pictureURL)
                    
                    let userInfo = [
                        "name": userData["name"]!,
                        "profilePicture": pictureURL!
                    ]
                    
                    print(userInfo)
                    
                    let user = [uid: userInfo]
                    
                    self.ref.childByAppendingPath("users").updateChildValues(user)
                    
                    print(userData)
                    print(NSURL(string: pictureURL!)!)
                    
                    self.imageDownloader.downloadImageWithURL(NSURL(string: pictureURL!)!, options: SDWebImageDownloaderOptions.HighPriority, progress: {
                        (start, finish) in
                        print(start, finish)
                        }, completed: {
                        (image, data, error, bool) in
                        if error == nil {
                            let newUser = User(value: [
                                "uid": uid,
                                "name": userData["name"]!,
                                "profilePicture": data
                            ])
                            
                            let newCurrentUser = CurrentUser(value: [newUser, 0])
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                try! self.realm.write {
                                    self.realm.add(newCurrentUser, update: true)
                                    completion(true)
                                }
                            })
                        }
                        
                    })
//                    let newUser = User(value: [
//                        "uid": uid,
//                        "name": userData["name"]!,
//                        "profilePicture":
                    
                    
                    
                }
            })
        }
    }
    
    

}

