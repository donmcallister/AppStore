//
//  AppGroup.swift
//  AppStore
//
//  Created by Donald McAllister on 5/13/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
    
}
