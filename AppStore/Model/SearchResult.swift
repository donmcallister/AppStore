//
//  SearchResult.swift
//  AppStore
//
//  Created by Donald McAllister on 5/12/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
}
