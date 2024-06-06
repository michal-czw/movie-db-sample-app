//
//  NowPlayingSceneRouter.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

protocol NowPlayingSceneRoutingLogic {
    
    func showMovieDetails(id: Int)
    
}

final class NowPlayingSceneRouter {
    
    weak var source: UIViewController?
    
    private let sceneFactory: NowPlayingSceneFactory
    
    init(sceneFactory: NowPlayingSceneFactory, source: UIViewController? = nil) {
        self.sceneFactory = sceneFactory
        self.source = source
    }
    
}

extension NowPlayingSceneRouter: NowPlayingSceneRoutingLogic {
    
    func showMovieDetails(id: Int) {
        let viewController = sceneFactory.makeMovieDetailsSceneViewController(id: id)
        source?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
