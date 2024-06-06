//
//  MovieDetailsSceneConfigurator.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

protocol MovieDetailsSceneConfigurable {
    func configure() -> MovieDetailsSceneViewController
}

final class MovieDetailsSceneConfigurator {
    private var service: MoviesProvidingService
    private var id: Int
    
    init(
        id: Int,
        service: MoviesProvidingService
    ) {
        self.id = id
        self.service = service
    }
}

extension MovieDetailsSceneConfigurator: MovieDetailsSceneConfigurable {
    
    func configure() -> MovieDetailsSceneViewController {
        let viewController = MovieDetailsSceneViewController()
        
        let worker = MovieDetailsSceneWorker(service: service)
        let presenter = MovieDetailsScenePresenter(viewController: viewController)
        let interactor = MovieDetailsSceneInteractor(id: id, presenter: presenter, worker: worker)
        
        viewController.interactor = interactor
        
        return viewController
    }
    
}
