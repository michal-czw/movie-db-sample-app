//
//  MoviesService.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import Foundation

protocol MoviesProvidingService: Service {
    func fetchNowPlaying(page: Int) async throws -> NowPlayingResponse
    func fetchMovie(id: Int) async throws -> Movie
}

struct MoviesService: MoviesProvidingService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = TMDB.appProvider.urlSession) {
        self.urlSession = urlSession
    }
    
    func fetchNowPlaying(page: Int = 1) async throws -> NowPlayingResponse {
        let endpoint = Endpoint(
            path: "/\(ServiceConfiguration.apiVersion)/movie/now_playing",
            queryItems: [
                URLQueryItem(name: "page", value: String(page))
            ]
        )
        
        guard let request = endpoint.urlRequest else {
            throw ServiceError.invalidRequest
        }
        
        return try await fetchRequest(request)
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        let endpoint = Endpoint(
            path: "/\(ServiceConfiguration.apiVersion)/movie/\(id)"
        )
        
        guard let request = endpoint.urlRequest else {
            throw ServiceError.invalidRequest
        }
        
        return try await fetchRequest(request)
    }
    
}
