//
//  CultureFlagView.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/21/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

class CultureFlagView: UIView {
    
    var view: UIView!
    var culture: String!
    var index: Int!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        xibSetup()
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CultureFlagView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    init(frame: CGRect, culture: String, index: Int) {
        super.init(frame: frame)
        
        xibSetup()
        
        self.culture = culture
        self.index = index
        flagImageView.image = UIImage(named: culture)
    }


}
