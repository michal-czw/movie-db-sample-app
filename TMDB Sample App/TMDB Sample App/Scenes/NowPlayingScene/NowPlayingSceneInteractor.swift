//
//  NowPlayingSceneInteractor.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

typealias NowPlayingSceneInteractorInput = NowPlayingSceneViewControllerOutput

protocol NowPlayingSceneInteractorOutput: AnyObject {
    
    func showResults(_ items: [Movie])
    func appendResults(_ items: [Movie], at indexPaths: [IndexPath])
    func showLoadingIndicator()
    func showLoadingError(_ message: String)
    
}

protocol NowPlayingSceneDataStore {
    
    var moviesCount: Int { get }
    
    func viewModel(at indexPath: IndexPath) -> NowPlayingCellViewModel
    
}

final class NowPlayingSceneInteractor {
    var presenter: NowPlayingScenePresenterInput?
    var worker: NowPlayingSceneWorker?
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var viewModels: [NowPlayingCellViewModel] = []
    private(set) var viewState: ViewState = .ready([])
    
    init(presenter: NowPlayingScenePresenterInput?,
         worker: NowPlayingSceneWorker?
    ) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension NowPlayingSceneInteractor: NowPlayingSceneInteractorInput {
    
    func loadFirstPage() async {
        presenter?.showLoadingIndicator()
        await loadPage(1)
    }
    
    func loadNextPage() async {
        await loadPage(currentPage + 1)
    }
    
    private func loadPage(_ page: Int) async {
        guard !viewState.isLoading, page <= totalPages else {
            return
        }
        
        do {
            viewState = .loading
            guard let response = try await worker?.fetchPage(page) else {
                return
            }
            currentPage = response.page
            totalPages = response.totalPages
            
            let viewModels = response.results.map(\.asCellViewModel)
            if page == 1 {
                self.viewModels = viewModels
                presenter?.showResults(response.results)
            } else {
                let count = self.viewModels.count
                let fetchedModelsCount = viewModels.count
                let indexPathsToInsert = (count ..< count+fetchedModelsCount).map {
                    IndexPath(item: $0, section: 0)
                }
                self.viewModels.append(contentsOf: viewModels)
                presenter?.appendResults(response.results, at: indexPathsToInsert)
            }
            
            viewState = .ready(response.results)
        } catch {
            viewState = .failure(error)
            presenter?.showLoadingError(error.localizedDescription)
        }
    }
}

extension NowPlayingSceneInteractor: NowPlayingSceneDataStore {
    
    var moviesCount: Int {
        viewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> NowPlayingCellViewModel {
        viewModels[indexPath.row]
    }
    
}
