//
//  AppDelegate.swift
//  SFCulture
//
//  Created by Jimmy Yue on 11/19/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

//        Parse.enableLocalDatastore()
//        Parse.setApplicationId("huCV5qt0PKqorf1aYHbv93jQo7nWZNdvZtP58t9w",
//            clientKey: "6NbhqNdcQiuQd7wGaXS3XFLnPYdGGTMc0CwQuVhz")
//        
//        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
//
//        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
//        
//        let user = PFUser.currentUser()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }


}

