
//
//  LoginViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/7/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class LoginViewController: UIViewController {
    
    let realm = try! Realm()
    let helper = APIHelper()
    
    private let loginHelper = FirebaseLoginHelper()
    private let apiHelper = APIHelper()
    
    // MARK: Outlets
    @IBOutlet weak var loginWithFacebookButton: LoginWithFacebook!
    
    // Keeps the Rx resources for deinit()
    let disposeBag = DisposeBag()
    
    var loginErrorAlert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginWithFacebookButton.cellButton.addTarget(self, action: "loginWithFacebookButtonPressed:", forControlEvents: .TouchUpInside)
        
        loginErrorAlert = UIAlertController(title: "Something went wrong, please try again!", message: "", preferredStyle: .Alert)
        loginErrorAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
        
    }
    
    func loginWithFacebookButtonPressed(sender: UIButton) {
        print("pressed")
        showLoadingIndicator("Logging In", view: self.view)
        loginHelper.login(self) { (success) -> Void in
            if success {
                print(success)
//                self.hideLoadingIndicator()
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let currentUser = self.realm.objects(CurrentUser)[0]
                self.apiHelper.getCultureForUser((currentUser.user?.uid)!, handler: { result, error in
                    if let error = error {
                        print(error)
                    }
                    else {
//                        if let culture = result {
                        print(result)
                        let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("checkCulture")
                        cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                        self.presentViewController(cultureVC, animated: true, completion: nil)
//                        }
//                        else {
//                            print(result)
//                            let cultureSelectVC = mainStoryboard.instantiateViewControllerWithIdentifier("selectCulture")
//                            cultureSelectVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//                            self.presentViewController(cultureSelectVC, animated: true, completion: nil)
//                        }
                    }
                })
//                if let usersCulture = currentUser.user?.culture {
//                    let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("culture")
//                    cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//                    self.presentViewController(cultureVC, animated: true, completion: nil)
//                }
                
            }
            else {
                print(success)
                self.hideLoadingIndicator()
                self.presentViewController(self.loginErrorAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showLoadingIndicator(title: String, view: UIView){
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "", andFooter: title)
    }
    
    func hideLoadingIndicator(){
        JHProgressHUD.sharedHUD.hide()
    }


}
