
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
    
    // MARK: Outlets
    @IBOutlet weak var loginWithFacebookButton: UIButton!
    
    // Keeps the Rx resources for deinit()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }


}
