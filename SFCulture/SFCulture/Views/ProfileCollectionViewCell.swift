//
//  ProfileCollectionViewCell.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/6/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif
import SDWebImage

class ProfileCollectionViewCell: UICollectionViewCell {
    
    var view: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        xibSetup()
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ProfileCollectionViewCell", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    init(frame: CGRect,  imageUrl: String, profileName: String, profileCaption: String) {
        super.init(frame: frame)
        
        xibSetup()
        
        name.text = profileName
        caption.text = profileCaption
        
        profileImage.sd_setImageWithURL(NSURL(string: imageUrl))
        
    }
    
}
