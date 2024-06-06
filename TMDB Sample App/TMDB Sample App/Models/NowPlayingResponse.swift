//
//  NowPlayingResponse.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import Foundation

struct NowPlayingResponse: Decodable {

    let page: Int
    let totalPages: Int
    let results: [Movie]
    
}
