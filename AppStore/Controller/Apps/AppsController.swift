//
//  AppsController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/13/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//
//Continuing insutrction from BaeTabBarController...
//11 - create new group inside Views named Apps for our AppsGroupCell..add init code.
//12 - now let's focus on AppController...
//13 - add AppsGroupCell instead...in register code and remove .lightgray since trying to make the SearchResultCell change this property..
//14 - adding titleLabel in AppsGroupCell and cleaning up code with convenience extension
//

import UIKit

class AppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "id"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
        collectionView.register(
            AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        //cell.backgroundColor = .lightGray
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    

}
