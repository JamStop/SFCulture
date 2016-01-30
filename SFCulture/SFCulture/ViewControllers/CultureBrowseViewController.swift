//
//  CultureBrowseViewController.swift
//  SFCulture
//
//  Created by Jimmy Yue on 1/11/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import UIKit

class CultureBrowseViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension CultureBrowseViewController: UICollectionViewDelegate {
    
}

//extension CultureBrowseViewController: UICollectionViewDataSource {
//    
//}
