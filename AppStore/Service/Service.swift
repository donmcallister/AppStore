//
//  Service.swift
//  AppStore
//
//  Created by Donald McAllister on 5/12/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() //singleton
    
    func fetchApps(searchTerm: String, completion:@escaping ([Result], Error?) -> ()) {
        print("Fetching itunes apps from Service layer")
        let urlString =  "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else {return}
        
        //fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("failed to fetch apps:", err)
                completion([], nil)
                return
            }
            
            
            //success
            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
              completion(searchResult.results, nil)
                
            } catch let jsonErr{
                print("Failed to decode JSONL:", jsonErr)
                completion([], jsonErr)
            }
            
            }.resume() //fires off the request - easily forget this..

    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
        
    }
    
    //helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            //print(data)
            
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                // print(appGroup.feed.results)
                // appGroup.feed.results.forEach({print($0.name)})
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: \(error)")
            }
            
            }.resume() //this will fire your request
}
}

