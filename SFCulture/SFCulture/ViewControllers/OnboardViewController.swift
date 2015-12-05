//
//  OnboardViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/3/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

class OnboardViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showLoadingIndicator("Checking Facebook details...", view: self.view)
    }
    
    func showLoadingIndicator(title: String, view: UIView){
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "", andFooter: title)
    }

}


