//
//  NowPlayingSceneViewController.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import Combine
import UIKit

protocol NowPlayingSceneViewControllerInput: AnyObject {
    
    func reloadData()
    func insertItems(at indexPaths: [IndexPath])
    func showLoadingIndicator()
    func showError(message: String)
    
}

protocol NowPlayingSceneViewControllerOutput: AnyObject {
    
    func loadFirstPage() async
    func loadNextPage() async
    
}

final class NowPlayingSceneViewController: UICollectionViewController {
    
    private enum Constants {
        static let cellIdentifier = "cell"
        static let itemHeight: CGFloat = 300
        static let interitemSpacing: CGFloat = 10
        static let numberOfItemsInRow = 2
        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    var interactor: NowPlayingSceneInteractorInput?
    var dataStore: NowPlayingSceneDataStore?
    var router: NowPlayingSceneRoutingLogic?
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        Task {
            await interactor?.loadFirstPage()
        }
    }
    
    private func setUpViews() {
        title = "Now Playing Movies"
        
        collectionView.register(
            NowPlayingCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(loadingIndicator)
        view.addConstraints([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc private func refreshData() {
        Task {
            await interactor?.loadFirstPage()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataStore?.moviesCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = dataStore?.viewModel(at: indexPath) else {
            fatalError("Couldn't find viewModel at \(indexPath)")
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as! NowPlayingCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = dataStore?.viewModel(at: indexPath) else {
            fatalError("Couldn't find viewModel at \(indexPath)")
        }
        
        router?.showMovieDetails(id: model.id)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let dataStore else { return }
        
        let shouldLoadNextPage = indexPath.item >= dataStore.moviesCount - 6
        if shouldLoadNextPage {
            Task {
                await interactor?.loadNextPage()
            }
        }
    }
    
}

extension NowPlayingSceneViewController: NowPlayingSceneViewControllerInput {
    
    func reloadData() {
        loadingIndicator.stopAnimating()
        collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
    
    func insertItems(at indexPaths: [IndexPath]) {
        guard let moviesCount = dataStore?.moviesCount,
              let lastIndexPathItemToInsert = indexPaths.last?.item,
              lastIndexPathItemToInsert < moviesCount else {
            collectionView.reloadData()
            return
        }
        
        collectionView.insertItems(at: indexPaths)
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func showError(message: String) {
        loadingIndicator.stopAnimating()
        collectionView.refreshControl?.endRefreshing()
    }
    
}

extension NowPlayingSceneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.interitemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentWidth = collectionView.frame.width
        - Constants.sectionInsets.left
        - Constants.sectionInsets.right
        - Constants.interitemSpacing
        let itemWidth = (contentWidth / CGFloat(Constants.numberOfItemsInRow)).rounded(.down)
        return CGSize(width: itemWidth, height: Constants.itemHeight)
    }
    
}
