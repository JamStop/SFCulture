//
//  ParseLoginHelper.swift
//  SFCulture
//
//  Created by Jimmy Yue on 11/20/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import Parse
import ParseUI
import SwiftyJSON
import FBSDKCoreKit

typealias ParseLoginHelperCallback = (PFUser?, NSError?) -> Void

class ParseLoginHelper : NSObject
{
    let callback: ParseLoginHelperCallback
    init(callback: ParseLoginHelperCallback) { self.callback = callback }
}

extension ParseLoginHelper : PFLogInViewControllerDelegate
{
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        // Determine if this is a Facebook login
        let isFacebookLogin = FBSDKAccessToken.currentAccessToken() != nil
        
        if !isFacebookLogin
        {
            // Plain parse login, we can return user immediately
            self.callback(user, nil)
        }
        else
        {
            // if this is a Facebook login, fetch the username from Facebook
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,name,email,picture"]).startWithCompletionHandler {(connection: FBSDKGraphRequestConnection!, result: AnyObject?, error: NSError?) -> Void in
                
                if let error = error
                {
                    // Facebook Error? -> hand error to callback
                    ErrorHandling.displayError(logInController, error: error)
                    self.callback(nil, error)
                }
                
                let fbID = result?["id"] as? String
                
                if let fbUsername = result?["name"] as? String
                {
                    // assign Facebook parameters to user - name, id, friendlist (more to come)
                    
                    let data = JSON(result!)
                    
                    user["fbID"]    = fbID
                    user["picture"] = "http://graph.facebook.com/" + fbID! + "/picture?width=300&height=300"
                    user.email      = data["email"].stringValue
                    user.username   = fbUsername.lowercaseString // stored using swift native syntax
                    
                    // store User
                    user.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        
                        if (success)
                        {
                            // updated user could be stored -> call success
                            self.callback(user, error)
                        }
                        else
                        {
                            // updating user failed -> hand error to callback
                            ErrorHandling.displayError(logInController, error: error!)
                            self.callback(nil, error)
                        }
                    })
                }
                else
                {
                    ErrorHandling.displayError(logInController, error: error!)
                    self.callback(nil, error)
                }
            }
        }
    }
}

extension ParseLoginHelper : PFSignUpViewControllerDelegate
{
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    { self.callback(user, nil)}
}
