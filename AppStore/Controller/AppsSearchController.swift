//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

// first cast dequed cell tin SearchResult Cell:
// let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
// then now have access:  cell.nameLabel.text = "HERE IS MY APP NAME"
// 1- fetchItunesApps() with URL string
// 2- fetch data from internet in this function: URLSession.shared.datatask()
// 3- hit enter for completion handlet
// 4- remember to add .resume() at end
// 5 - if let err = err...
// 6 - use print(data) to get size or print(String(data: data!, encoding: .utf8)) to print out entire API call in debug screen.
// 7 - JSON decodable object using a struct SearchResult with whatever fields you want to get back and set it to Decodable..
// 8- now in success case: JSONDecoder().decode(data) or (SearchResult.self, from: data) == searchResult -- put into a DO CATCH BLOCK and add try...
// 9- print(searchResult) - hard to read so better option:
// 10- searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
// 11- create a Model group and SearchResult.swift and add the two objects created into it.. (the two structs)


class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
    }
    
    //to create a JSON decodable object(this will be put into its own file:
    
//    struct SearchResult: Decodable {
//        let resultCount: Int
//        let results: [Result]
//    }
//    
//    struct Result: Decodable {
//        let trackName: String
//        let primaryGenreName: String
//    }
    
    
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
            print(data)
            //print a string
            print(String(data: data!, encoding: .utf8))
            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
                
            } catch let jsonErr{
                print("Failed to decode JSONL:", jsonErr)
            }
            
            
            
        }.resume() //fires off the request - easily forget this..
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.nameLabel.text = "HERE IS MY APP NAME"
        return cell
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
