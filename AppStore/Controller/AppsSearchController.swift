//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit


class AppsSearchController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .red
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
