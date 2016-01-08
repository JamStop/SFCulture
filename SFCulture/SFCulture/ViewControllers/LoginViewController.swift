
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

class LoginViewController: UIViewController {
    
    private let loginHelper = FirebaseLoginHelper()
    
    // MARK: Outlets
    @IBOutlet weak var loginWithFacebookButton: LoginWithFacebook!
    
    // Keeps the Rx resources for deinit()
    let disposeBag = DisposeBag()
    
    let loginErrorAlert = UIAlertController(title: "Something went wrong, please try again!", message: "", preferredStyle: .Alert)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginWithFacebookButton.cellButton.addTarget(self, action: "loginWithFacebookButtonPressed:", forControlEvents: .TouchUpInside)
        
        loginErrorAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
        
    }
    
    func loginWithFacebookButtonPressed(sender: UIButton) {
        print("pressed")
        showLoadingIndicator("Logging In", view: self.view)
        loginHelper.login(self) { (success) -> Void in
            if success {
                print(success)
                self.hideLoadingIndicator()
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
