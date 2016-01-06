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
    
    override func viewDidLoad() {
        self.view.userInteractionEnabled = true
        searchBar.autocapitalizationType = UITextAutocapitalizationType.None
        
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.type = iCarouselType.Rotary
        
        setupTouchEvents()

    }
    
    func setupTouchEvents() {
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        self.view.addGestureRecognizer(dismiss)
    }
    
    func dismissKeyboard(gestureRecognizer: UIGestureRecognizer) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

extension CultureSelectionViewController: iCarouselDelegate {
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        return
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
    func carouselDidScroll(carousel: iCarousel!) {
        return
    }
}
