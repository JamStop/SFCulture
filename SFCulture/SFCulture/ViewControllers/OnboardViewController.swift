//
//  OnboardViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/3/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        
//        showLoadingIndicator("Checking Facebook details...", view: self.view)
        
        
    }
    
    
    
    func showLoadingIndicator(title: String, view: UIView){
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "", andFooter: title)
    }
    
    func hideLoadingIndicator(){
        JHProgressHUD.sharedHUD.hide()
    }

}

extension OnboardViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}

extension OnboardViewController: UIPageViewControllerDelegate {
    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}


