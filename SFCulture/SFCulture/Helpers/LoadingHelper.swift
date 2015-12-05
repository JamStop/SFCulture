//
//  LoadingHelper.swift
//  SFCulture
//
//  Created by Jimmy Yue on 12/5/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import UIKit

struct LoadingHelper {
    
    func showLoadingIndicator(title: String, view: UIView){
        
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "", andFooter: title)
    }
}