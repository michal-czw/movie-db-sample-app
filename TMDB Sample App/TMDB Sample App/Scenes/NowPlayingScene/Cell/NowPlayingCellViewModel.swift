//
//  NowPlayingCellViewModel.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

struct NowPlayingCellViewModel {
    
    let id: Int
    let title: String
    let poster: URL?
    
}

extension Movie {
    
    var asCellViewModel: NowPlayingCellViewModel {
        let baseUrl = TMDB.appProvider.configuration?.images.baseUrl
        let posterUrl = baseUrl.flatMap { host in
            posterPath.flatMap {
                Endpoint(host: host, path: "/w500/\($0)").url
            }
        }
        
        return NowPlayingCellViewModel(
            id: self.id,
            title: self.title,
            poster: posterUrl
        )
    }
    
}
