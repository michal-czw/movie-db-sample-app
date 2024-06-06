//
//  MovieDetailsSceneInteractor.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

typealias MovieDetailsSceneInteractorInput = MovieDetailsSceneViewControllerOutput

protocol MovieDetailsSceneInteractorOutput: AnyObject {
    
    func showResult(_ movie: Movie)
    func showFavoriteStatus(isFavorite: Bool)
    func showLoadingIndicator()
    func showLoadingError(_ message: String)
    
}

final class MovieDetailsSceneInteractor {
    var presenter: MovieDetailsScenePresenterInput?
    var worker: MovieDetailsSceneWorker?
    
    private let id: Int
    
    private var isFavorite: Bool {
        FavoriteChangeset.sharedInstance.isFavorite(id: id)
    }
    
    init(
        id: Int,
        presenter: MovieDetailsScenePresenterInput?,
        worker: MovieDetailsSceneWorker?
    ) {
        self.id = id
        self.presenter = presenter
        self.worker = worker
        FavoriteChangeset.sharedInstance.observe(id: id, with: self)
    }
}

extension MovieDetailsSceneInteractor: MovieDetailsSceneInteractorInput {
    
    func loadMovieDetails() async {
        presenter?.showLoadingIndicator()
        
        do {
            guard let response = try await worker?.fetchMovie(id: id) else {
                return
            }
            
            presenter?.showResult(response)
            presenter?.showFavoriteStatus(isFavorite: isFavorite)
        } catch {
            presenter?.showLoadingError(error.localizedDescription)
        }
    }
    
    func toggleFavorite() {
        FavoriteChangeset.sharedInstance.toggleFavorite(id: id)
        presenter?.showFavoriteStatus(isFavorite: isFavorite)
    }
}

extension MovieDetailsSceneInteractor: FavoriteObserver {
    
    func onFavoriteChange(isFavorite: Bool) {
        presenter?.showFavoriteStatus(isFavorite: isFavorite)
    }
    
}
