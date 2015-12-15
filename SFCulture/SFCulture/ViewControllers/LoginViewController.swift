
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginWithFacebookButton.cellButton.addTarget(self, action: "loginWithFacebookButtonPressed:", forControlEvents: .TouchUpInside)
        
        
        
    }
    
    func loginWithFacebookButtonPressed(sender: UIButton) {
        print("pressed")
        loginHelper.login(self)
    }


}
