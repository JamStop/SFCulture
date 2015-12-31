//
//  CultureSelectionViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/17/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.size.width

class CultureSelectionViewController: UIViewController {
    
    @IBOutlet weak var carousel: iCarousel!
    
    override func viewDidLoad() {
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.type = iCarouselType.Rotary
    }

}

extension CultureSelectionViewController: iCarouselDelegate {
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        return
    }
    
}

extension CultureSelectionViewController: iCarouselDataSource {
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return 2
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        return CultureFlagView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.6, height: screenWidth * 0.3))
    }
    
    func carousel(carousel: iCarousel!, placeholderViewAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        return CultureFlagView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.6, height: screenWidth * 0.3))
    }
    
}

extension CultureSelectionViewController: UISearchBarDelegate {
    
}
