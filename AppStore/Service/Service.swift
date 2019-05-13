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
    
    func fetchApps(completion:@escaping ([Result], Error?) -> ()) {
        print("Fetching itunes apps from Service layer")
        let urlString =  "https://itunes.apple.com/search?term=instagram&entity=software"
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
}
