//
//  IntermediateViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/9/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase


class IntermediateViewController: UIViewController {
    let realm = try! Realm()
    private let apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator("Fetching your culture...", view: self.view)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showLoadingIndicator(title: String, view: UIView){
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "", andFooter: title)
    }
    
    func getCulture() -> String {
        let currentUser = self.realm.objects(CurrentUser)[0]
        self.apiHelper.getCultureForUser((currentUser.user?.uid)!, handler: { result, error in
            if let error = error {
                print(error)
            }
            else {
                print(result)
                
//                let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("culture")
//                cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//                self.presentViewController(cultureVC, animated: true, completion: nil)
                //                        }
                //                        else {
                //                            print(result)
                //                            let cultureSelectVC = mainStoryboard.instantiateViewControllerWithIdentifier("selectCulture")
                //                            cultureSelectVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                //                            self.presentViewController(cultureSelectVC, animated: true, completion: nil)
                //                        }
            }

        })
        return ""
    }
    
    
}
