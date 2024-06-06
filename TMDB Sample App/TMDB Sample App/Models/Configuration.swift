//
//  Configuration.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

struct Configuration: Decodable {
    
    struct Images: Decodable {
        
        let baseUrl: URL
        
        enum CodingKeys: String, CodingKey {
            case baseUrl = "secureBaseUrl"
        }
        
    }
    
    let images: Images
    
}
