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

class OnboardPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        setViewControllers([getSecondLandingViewController()], direction: .Forward, animated: false, completion: nil)
        
        
    }
    
    func getFirstLandingViewController() -> UIViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("Landing1")
    }
    
    func getSecondLandingViewController() -> UIViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("Landing2")
    }
    
    func getThirdLandingViewController() -> UIViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("Landing3")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}



extension OnboardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.restorationIdentifier == "Landing1" {
            return getSecondLandingViewController()
        }
        else if viewController.restorationIdentifier == "Landing2" {
            return getThirdLandingViewController()
        }
        return getFirstLandingViewController()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.restorationIdentifier == "Landing3" {
            return getSecondLandingViewController()
        }
        else if viewController.restorationIdentifier == "Landing1" {
            return getThirdLandingViewController()
        }
        return getFirstLandingViewController()
    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
}

extension OnboardPageViewController: UIPageViewControllerDelegate {
    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}


