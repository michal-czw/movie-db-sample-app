//
//  NowPlayingSceneWorker.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Combine
import Foundation

protocol NowPlayingSceneLogic {
    
    func fetchNowPlaying() async throws -> NowPlayingResponse
    func fetchPage(_ page: Int) async throws -> NowPlayingResponse
    
}

final class NowPlayingSceneWorker {
    
    private let service: MoviesProvidingService
    
    init(service: MoviesProvidingService) {
        self.service = service
    }
    
}

extension NowPlayingSceneWorker: NowPlayingSceneLogic {
    
    func fetchNowPlaying() async throws -> NowPlayingResponse {
        try await fetchPage(1)
    }
    
    func fetchPage(_ page: Int) async throws -> NowPlayingResponse {
        try await service.fetchNowPlaying(page: page)
    }
    
}
