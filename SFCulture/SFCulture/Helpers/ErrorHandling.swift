//
//  ErrorHandling.swift
//  SFCulture
//
//  Created by Jimmy Yue on 11/20/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandling
{
    static func displayError(controller: UIViewController, error: NSError)
    {
        let alertController = UIAlertController(
            title: "Error",
            message: error.description,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
