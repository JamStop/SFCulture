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
        
        getCulture() { (culture, error) in
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            if culture == nil {
                let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("selectCulture")
                cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(cultureVC, animated: true, completion: nil)
            }
            
            else {
                let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("culture")
                cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(cultureVC, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showLoadingIndicator(title: String, view: UIView){
        JHProgressHUD.sharedHUD.showInView(view, withHeader: title, andFooter: "")
    }
    
    func getCulture(handler: (result: String?, error: String?) -> Void) {
        let currentUser = self.realm.objects(CurrentUser)[0]
        self.apiHelper.getCultureForUser((currentUser.user?.uid)!, handler: { result, error in
            if let error = error {
                print(error)
            }
            else {
                print(result)
                
                guard let culture = result else {
                    handler(result: nil, error: "Need to set user culture")
                    return
                }
                try! self.realm.write {
                    currentUser.user?.culture = Culture(value: ["name": culture])
                }
                
                handler(result: culture, error: nil)
                
                
                
                
                
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
    }
    
    
}
