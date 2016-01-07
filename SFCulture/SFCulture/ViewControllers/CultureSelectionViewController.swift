//
//  CultureSelectionViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/17/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import RxSwift

let screenWidth = UIScreen.mainScreen().bounds.size.width

class CultureSelectionViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var carousel: iCarousel!
    
    @IBOutlet weak var cultureName: UILabel!
    
    var searching = false
    
    override func viewDidLoad() {
        self.view.userInteractionEnabled = true
        searchBar.autocapitalizationType = UITextAutocapitalizationType.None
        
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.type = iCarouselType.Rotary
        
        cultureName.text = "MakeSchool"
        
//        setupTouchEvents()
        
        configureSearchBar()

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
        
        fadeCultureNameOut()
    }
    
//    func carouselWillBeginScrollingAnimation(carousel: iCarousel!) {
//        fadeCultureNameOut()
//    }
    
    func carouselDidEndScrollingAnimation(carousel: iCarousel!) {
        fadeCultureNameIn()
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
