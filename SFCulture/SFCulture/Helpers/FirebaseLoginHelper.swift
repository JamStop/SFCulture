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

let firebase = Firebase(url: constants.API_URL)
let facebookLogin = FBSDKLoginManager()

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
                firebase.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                        }
                })
            }
        })
    }
}