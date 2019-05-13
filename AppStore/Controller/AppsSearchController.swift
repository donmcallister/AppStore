//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

// Separate JSON fetch logic into Service.swift
// Create class Service with singleton and empty function name
// come back here to AppSearchcontroller and comment out everything inside fetchItunesApps(_
// Service.shared.fetchApps() call
// head back into Service.swift and update inside function: print("fetching...")
// copy and paste commented section into Service.swift fetch function and delete
// now in Service.swift we no longer have access to self.appResults and self.collectionView, so delete those lines of code..
// So question is how do we pass our searchResult back into our AppsSearchController???
// We'll use a completion block, head into Service and add a parameter..
// looks like this: fetchApps(completion:() -> () )
// and then inside fetchApps call the completion block: completion() and then choose fix to have xcode add the @escaping piece to the parameter...
// and now still error: need to call Service.shared.fetchApps() with completion piece..[hit enter] -   print("Finished fetching apps from controller")
// now actually get back search results my modifying inside completion block in Service.swift
// fetchApps(completion:@escaping ([Result]) -> ())
//   completion(searchResult.results)
// and once again make the call Service.shared.fetchApps()
//Service.shared.fetchApps { (<#[Result]#>) in -- hit enter (result) in
//self.appResults = result AND:  self.collectionView.reloadData() place inside...
// pass error back through completion handler. so err and jsonErr
// func fetchApps(completion:@escaping ([Result], Error?)
// completion(searchResult.results, nil)
// inside err ---  completion([], nil)
// inside catch jsonErr --- completion([], jsonErr)
// now inside AppsSearchController fix argument needed now..call function again!! :
// Service.shared.fetchApps { (<#[Result]#>, <#Error?#>) in
// Service.shared.fetchApps { (results, err) in


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
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        
        return cell
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
