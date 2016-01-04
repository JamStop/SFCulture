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

let constants = Constants.sharedInstance

let ref = Firebase(url: constants.API_URL)
let facebookLogin = FBSDKLoginManager()

//typealias loginHandler = (status) -> 

class FirebaseLoginHelper {

    func login(viewController: UIViewController) {
        facebookLogin.logInWithReadPermissions(["public_profile", "user_friends", "email"], fromViewController: viewController, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print(facebookResult)
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            print(authData.provider)
                            
                            
                            self.getFBUserData()
                        }
                })
            }
        })
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
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
                    
                    ref.childByAppendingPath("users").childByAppendingPath(uid).setValue(userInfo)
                    
                    print(userData)
                    
                }
            })
        }
    }
    
    

}

