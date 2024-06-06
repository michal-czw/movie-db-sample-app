//
//  MovieDetailsViewModel.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

struct MovieDetailsViewModel {
    
    let title: String
    let description: String
    let poster: URL?
    let rating: String
    let releaseDate: String
    
}

extension Movie {
    
    var asMovieDetailsViewModel: MovieDetailsViewModel {
        let baseUrl = TMDB.appProvider.configuration?.images.baseUrl
        let posterUrl = baseUrl.flatMap { host in
            posterPath.flatMap {
                Endpoint(host: host, path: "/w780/\($0)").url
            }
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let number = NSNumber(value: voteAverage / 10)
        let formattedValue = formatter.string(from: number)!
        
        return MovieDetailsViewModel(
            title: self.title,
            description: overview,
            poster: posterUrl,
            rating: "Rating: \(formattedValue)",
            releaseDate: "Release date: \(self.releaseDate)"
        )
    }
    
}
