//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit
import SDWebImage

//Search Bar Controller and Search Throttling
// 1-  fileprivate let searchController = UISearchController(searchResultsController: nil)
// 2- in viewDidLoad call a function we'll create: setupSearchBar() and place inside:
// 3- navigationItem.searchController = self.searchController
// 4 -navigationItem.hidesSearchBarWhenScrolling = false
// 5 -now we want to be notified whenever text being typed into search field: searchController.searchBar.delegate = self
// 6-fix error and conform to UISearchBarDelegate
// 7-func searchBar(textDidChange) call and print(searchText) to see in console
// 8-now need to update fetch function and pass in search text to update "term=instagram"
// 9-in Service.swift, add parameter: fetchApps(searchTerm: String, completion....)
// 10- make call to  Service.shared.fetchApps(searchTerm: searchText) inside searchBar()
// 11- remove blue background color and now need delay in showing results: search throttling
// 12 -  var timer: Timer?
// 13 -  timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
// 14 - copy and paste inside this: Service.shared.fetchApps(searchTerm: searchText)...
// 15 - then kind of strangely you still get aggresive search so need to invalidate this timer: timer?.invalidate() so it no longer fires after the 0.5 delay...
// 16 - remove fetchItunesApps() inside viewDidLoad since don't want automatic search showing BUT now get a blank screen so let's add a label
// 17 - fileprivate let enterSearchTermLabel: UILabel.....
//18 - add it to screen: view.addSubview(enterSearchTermLabel)
//19 - enterSearchTermLabel.fillSuperview()
//20 need to hide label on search, done inside numberOfItemsInSection:   enterSearchTermLabel.isHidden = appResults.count != 0
//21 - now add into collection view so it looks better on searching: collectionView.addSubview(enterSearchTermLabel)
//22 - add constraints/padding: enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    fileprivate let cellId = "id1234"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
      //  fetchITunesApps()
    }
    
    fileprivate func setupSearchBar() {
    
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false //since hidden by default
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        //introduce some delay before performing the search
        //throttling the search
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            //this will actually fire my search
            Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
                self.appResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
      
    }
    fileprivate var appResults = [Result]() //our result object we extracted into SearchResult.swift
    
    
    fileprivate func fetchITunesApps() {

        Service.shared.fetchApps(searchTerm: "Twitter") { (results, err) in
            
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
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        //cell.nameLabel.text = "HERE IS MY APP NAME"
        
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        
        return cell
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
