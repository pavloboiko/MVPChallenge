//
//  UpComingMovies.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation

struct UpcomingMovies : Codable {
    
    let results : [Movie]?
    let page : Int
    let totalResults : Int
    let totalPages : Int
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
