//
//  NowPlayingSceneConfigurator.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

protocol NowPlayingSceneConfigurable {
    func configure() -> NowPlayingSceneViewController
}

final class NowPlayingSceneConfigurator {
    private var sceneFactory: NowPlayingSceneFactory
    private var service: MoviesProvidingService
    
    init(
        sceneFactory: NowPlayingSceneFactory,
        service: MoviesProvidingService
    ) {
        self.sceneFactory = sceneFactory
        self.service = service
    }
}

extension NowPlayingSceneConfigurator: NowPlayingSceneConfigurable {
    
    func configure() -> NowPlayingSceneViewController {
        let viewController = NowPlayingSceneViewController()
        
        let worker = NowPlayingSceneWorker(service: service)
        let presenter = NowPlayingScenePresenter(viewController: viewController)
        let interactor = NowPlayingSceneInteractor(presenter: presenter, worker: worker)
        let router = NowPlayingSceneRouter(sceneFactory: sceneFactory, source: viewController)
        
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        
        return viewController
    }
    
}
