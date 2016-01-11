//
//  CultureSelectionViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/17/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

let screenWidth = UIScreen.mainScreen().bounds.size.width

class CultureSelectionViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var scrolling = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var carousel: iCarousel!
    
    @IBOutlet weak var cultureName: UILabel!
    
    let apiHelper = APIHelper()
    let realm = try! Realm()
    
    var cultureSelectionAlert: UIAlertController!
    
    var searching = false
    
    @IBAction func selectCultureButtonTapped(sender: UIButton) {
        if !scrolling {
            self.presentViewController(cultureSelectionAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        self.view.userInteractionEnabled = true
        searchBar.autocapitalizationType = UITextAutocapitalizationType.None
        
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.type = iCarouselType.Rotary
        
        cultureName.text = "MakeSchool"
        
//        setupTouchEvents()
        
        configureSearchBar()
        
        cultureSelectionAlert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .Alert)
        cultureSelectionAlert.addAction(UIAlertAction(title: "Yes", style: .Cancel, handler: { [unowned self] (alert: UIAlertAction!) in
            self.selectCulture()}))
        cultureSelectionAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))

    }
    
//    func setupTouchEvents() {
//        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
//        carousel.addGestureRecognizer(dismiss)
//    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    func fadeCultureNameOut() {
        UIView.animateWithDuration(0.25, animations: {
            self.cultureName.alpha = 0
            }) { Void in
               let view = self.carousel.currentItemView as! CultureFlagView
                self.cultureName.text = view.culture
        }
    }
    
    func fadeCultureNameIn() {
        UIView.animateWithDuration(0.25, animations: {
            self.cultureName.alpha = 1
        })
    }
    
    func configureSearchBar() {
        let scheduler = MainScheduler.sharedInstance
        
        searchBar.rx_text
            .asDriver()
            .throttle(0.3, scheduler)
            .distinctUntilChanged()
            .driveNext { query in
                let index = self.searchQuery(query)
                if index != -1 {
                    print(index)
                    self.searching = true
                    self.moveToIndex(index, completion: { Void in
                        self.searching = false
                    })
                }
            }
            .addDisposableTo(disposeBag)
                
                
        }
    
    func searchQuery(query: String) -> Int {
        if query != "" {
            var tempList: [String] = []
            let cultures = Cultures.sharedInstance.cultures
            for var index = 0; index < cultures.count; index += 1 {
                if cultures[index].lowercaseString.rangeOfString(query) != nil {
                    tempList.append(cultures[index])
                }
                
            }
            if tempList.count != 0 {
                let sorted = tempList.sort()
            
                return cultures.indexOf(sorted[0])!
            }
        }
        return -1
    }

    func moveToIndex(index: Int, completion: (Void) -> Void) {
        carousel.scrollToItemAtIndex(index, animated: true)
        completion()
    }

}




extension CultureSelectionViewController: iCarouselDelegate {
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        if searching == false {
            dismissKeyboard()
        }
    }
    
    func carouselDidScroll(carousel: iCarousel!) {
//        if searching == false {
//            dismissKeyboard()
//        }
        scrolling = true
        fadeCultureNameOut()
    }
    
    func carouselDidEndScrollingAnimation(carousel: iCarousel!) {
        fadeCultureNameIn()
        scrolling = false
    }
    
    func selectCulture() {
        let selectedCulture = cultureName.text
        let currentUser = self.realm.objects(CurrentUser)[0]
        apiHelper.setCultureForUser(currentUser.user!.uid, culture: selectedCulture!, handler: {
            result, error in
            if error != "" {
                print("Failed fetching data")
            }
            else {
                let culture = Culture()
                culture.name = selectedCulture!
                try! self.realm.write() {
                    currentUser.user?.culture = culture
                    self.segueToMainApp()
                }
            }
        })
    }
    
    func segueToMainApp() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("culture")
        cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(cultureVC, animated: true, completion: nil)
    }
    

    
}

extension CultureSelectionViewController: iCarouselDataSource {
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return Cultures.sharedInstance.cultures.count
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        return CultureFlagView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.8, height: screenWidth * 0.53), culture: Cultures.sharedInstance.cultures[index], index: index)
    }
    
    func carousel(carousel: iCarousel!, placeholderViewAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        return CultureFlagView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.8, height: screenWidth * 0.53), culture: Cultures.sharedInstance.cultures[index], index: index)
    }
    
}

extension CultureSelectionViewController: UISearchBarDelegate {
    
}
