//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit
import SDWebImage

// in SearchResult.swift add artworkUrl100: String and let screenshotUrls: [String]
// in cellForItemAt add now:  cell.appIconImageView and cell.screenshot1ImageView
// command click appIconImageView to enter file and comment these out for now..
// 

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
    }
    
    fileprivate var appResults = [Result]() //our result object we extracted into SearchResult.swift
    
    
    fileprivate func fetchITunesApps() {

        Service.shared.fetchApps { (results, err) in
            
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
             self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        //cell.nameLabel.text = "HERE IS MY APP NAME"
        
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        
        //moving the below over to SearchResultCell.swift:
        //and calling it inside didSet...
//        cell.nameLabel.text = appResult.trackName
//        cell.categoryLabel.text = appResult.primaryGenreName
//        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
//
//        let url = URL(string: appResult.artworkUrl100)
//        cell.appIconImageView.sd_setImage(with: url)
//        cell.screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
//        if appResult.screenshotUrls.count > 1 {
//            cell.screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
//        }
//        if appResult.screenshotUrls.count > 2 {
//            cell.screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
//        }
        
        
        
        
        return cell
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
