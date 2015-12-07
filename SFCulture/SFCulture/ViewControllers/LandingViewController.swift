//
//  LandingViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/6/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var bgImage: UIImage
    var bgCaption: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(image: String, caption: String) {
        
        bgImage = UIImage(named: image)!
        bgCaption = caption
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        bgImage = UIImage(named: "Landing1")!
        bgCaption = "Error: View Controller loaded from coder"
        
        super.init(coder: aDecoder)
    }

    func setup() {
        
    }

}
