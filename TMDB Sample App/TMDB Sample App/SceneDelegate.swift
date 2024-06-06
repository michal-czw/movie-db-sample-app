//
//  SceneDelegate.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UINavigationController(
//            rootViewController: NowPlayingViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        )
//        window.makeKeyAndVisible()
//        self.window = window
        
        
        let navigationController = UINavigationController()
        let sceneFactory = NowPlayingSceneFactory(
            navigationController: navigationController,
            service: MoviesService()
        )
        sceneFactory.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}
