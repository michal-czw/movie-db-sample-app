//
//  NowPlayingSceneFactory.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

protocol NowPlayingSceneFactoryLogic {
    func makeNowPlayingSceneViewController() -> NowPlayingSceneViewController
}

class NowPlayingSceneFactory: NowPlayingSceneFactoryLogic {
    var navigationController: UINavigationController
    let service: MoviesProvidingService
    
    init(
        navigationController: UINavigationController,
        service: MoviesProvidingService
    ) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let viewController = makeNowPlayingSceneViewController()
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func makeNowPlayingSceneViewController() -> NowPlayingSceneViewController {
        let configurator = NowPlayingSceneConfigurator(sceneFactory: self, service: service)
        let viewController = configurator.configure()
        return viewController
    }
    
    func makeMovieDetailsSceneViewController(id: Int) -> MovieDetailsSceneViewController {
        let configurator = MovieDetailsSceneConfigurator(id: id, service: service)
        let viewController = configurator.configure()
        return viewController
    }
}
