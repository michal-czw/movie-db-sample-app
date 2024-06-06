//
//  NowPlayingScenePresenter.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

typealias NowPlayingScenePresenterInput = NowPlayingSceneInteractorOutput
typealias NowPlayingScenePresenterOutput = NowPlayingSceneViewControllerInput

final class NowPlayingScenePresenter {
    weak var viewController: NowPlayingScenePresenterOutput?
    
    init(viewController: NowPlayingScenePresenterOutput) {
        self.viewController = viewController
    }
}

extension NowPlayingScenePresenter: NowPlayingScenePresenterInput {
    func showResults(_ items: [Movie]) {
        DispatchQueue.main.async {
            self.viewController?.reloadData()
        }
    }
    
    func appendResults(_ items: [Movie], at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.viewController?.insertItems(at: indexPaths)
        }
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.viewController?.showLoadingIndicator()
        }
    }
    
    func showLoadingError(_ message: String) {
        DispatchQueue.main.async {
            self.viewController?.showError(message: message)
        }
    }
}
