//
//  BaseListController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/13/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
