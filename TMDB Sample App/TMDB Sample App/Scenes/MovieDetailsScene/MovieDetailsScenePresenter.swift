//
//  MovieDetailsScenePresenter.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

typealias MovieDetailsScenePresenterInput = MovieDetailsSceneInteractorOutput
typealias MovieDetailsScenePresenterOutput = MovieDetailsSceneViewControllerInput

final class MovieDetailsScenePresenter {
    weak var viewController: MovieDetailsScenePresenterOutput?
    
    init(viewController: MovieDetailsScenePresenterOutput) {
        self.viewController = viewController
    }
}

extension MovieDetailsScenePresenter: MovieDetailsScenePresenterInput {
    func showFavoriteStatus(isFavorite: Bool) {
        viewController?.showFavoriteStatus(isFavorite: isFavorite)
    }
    
    func showResult(_ movie: Movie) {
        viewController?.showMovieDetails(viewModel: movie.asMovieDetailsViewModel)
    }
    
    func showLoadingIndicator() {
        viewController?.showLoadingIndicator()
    }
    
    func showLoadingError(_ message: String) {
        viewController?.showError(message: message)
    }
}
