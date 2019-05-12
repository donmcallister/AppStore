//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

// 1-  cellForItemAt
// 2-  cellId
// 3-  register cellId
// 4-  numberOfItemsInSection, return 5
// 5-  cell.backgroundColor = .red inside cellForItemAt method
// 6-  collectionView.backgroundColor = .white
// gives you five small cells which we will expand to size of screen next:
// 7- conform to UICollectionViewDelegateflowLayout to implement grid-based layout and define the size of items and the spacing between items in the grid.
// 8- now can override method: sizeForItemAt
// return CGSize or can use: return .init(width: view.frame.width, height: 250)
// 9- start drawing it out using custom subclass.. create a new group to organize: Views
//10 - create new cocoa touch class inside Views folder: SearchResultCell: UICollectionViewCell subclassing... and override init()
//11 - now back here we change register name from UICollectionViewCell to the SearchResultCell.self and remove color change line from cellForItemAt so will get color changed from inside the SearchResultCell init method..
//12 - start creating views inside SearchResultCell.swift.. 

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
