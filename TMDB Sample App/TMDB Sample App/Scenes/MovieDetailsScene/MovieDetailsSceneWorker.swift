//
//  MovieDetailsSceneWorker.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Combine
import Foundation

protocol MovieDetailsSceneLogic {
    
    func fetchMovie(id: Int) async throws -> Movie
    
}

final class MovieDetailsSceneWorker {
    
    private let service: MoviesProvidingService
    
    init(service: MoviesProvidingService) {
        self.service = service
    }
    
}

extension MovieDetailsSceneWorker: MovieDetailsSceneLogic {
    
    func fetchMovie(id: Int) async throws -> Movie {
        try await service.fetchMovie(id: id)
    }
    
}
