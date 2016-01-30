//
//  MessageBrowseViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/12/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import UIKit

class MessageBrowseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MessageBrowseViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height/5
    }
    
}

//extension MessageBrowseViewController: UITableViewDataSource {
//    func tableVi
//}
