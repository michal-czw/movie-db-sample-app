//
//  Endpoint.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import Foundation

struct Endpoint {
    
    let host: URL
    let path: String
    let queryItems: [URLQueryItem]?
    
    init(
        host: URL = URL(string: "https://api.themoviedb.org")!,
        path: String,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.host = host
        self.path = path
        self.queryItems = [
            URLQueryItem(name: "api_key", value: ServiceConfiguration.apiKey)
        ] + (queryItems ?? [])
    }
}

extension Endpoint {
    
    var url: URL? {
        var components = URLComponents(url: host, resolvingAgainstBaseURL: true)
        components?.path.append(path)
        components?.queryItems = queryItems
        return components?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
}
