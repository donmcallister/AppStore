//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

// 1- capture searchResult.results into a local variable: appResults
// self.appResults = searchResult.results
// in numberOfItemsInSection --. return appResults.count
// after self.appResults = searchResult.results make a call to self.collectionView.reloadData() since can't always guarantee internet connection and any issues grabbing the data from api
// But will need to then put it on the main thread: DispatchQueue.main.async {} since you can't modify any UI on background thread.


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
        let urlString =  "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {return}
        
        //fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("failed to fetch apps:", err)
                return
            }
            
    
            //success
            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                self.appResults = searchResult.results
                
                DispatchQueue.main.async { //get back on the main thread
                    self.collectionView.reloadData()
                }
                
                
//                searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
                
            } catch let jsonErr{
                print("Failed to decode JSONL:", jsonErr)
            }
            
            
            
        }.resume() //fires off the request - easily forget this..
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
