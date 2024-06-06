//
//  MovieDetailsSceneViewController.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

protocol MovieDetailsSceneViewControllerInput: AnyObject {
    
    func showMovieDetails(viewModel: MovieDetailsViewModel)
    func showFavoriteStatue(isFavorite: Bool)
    func showLoadingIndicator()
    func showError(message: String)
    
}

protocol MovieDetailsSceneViewControllerOutput: AnyObject {
    
    func loadMovieDetails() async
    func toggleFavorite()
    
}

final class MovieDetailsSceneViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = .init(top: 10, left: 15, bottom: 10, right: 15)
        return scrollView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var interactor: MovieDetailsSceneInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        Task {
            await interactor?.loadMovieDetails()
        }
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(loadingIndicator)
        
        view.addConstraints([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -(scrollView.contentInset.left + scrollView.contentInset.right)
            ),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

extension MovieDetailsSceneViewController: MovieDetailsSceneViewControllerInput {
    func showMovieDetails(viewModel: MovieDetailsViewModel) {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        loadingIndicator.stopAnimating()
        
        title = viewModel.title
        stackView.addArrangedSubview(MovieDetailsViewsBuilder.makePoster(url: viewModel.poster))
        stackView.addArrangedSubview(MovieDetailsViewsBuilder.makeTitleLabel(viewModel.title))
        stackView.addArrangedSubview(MovieDetailsViewsBuilder.makeInfoLabel(viewModel.releaseDate))
        stackView.addArrangedSubview(MovieDetailsViewsBuilder.makeInfoLabel(viewModel.rating))
        stackView.addArrangedSubview(MovieDetailsViewsBuilder.makeDescriptionLabel(viewModel.description))
    }
    
    func showFavoriteStatue(isFavorite: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorite ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func showError(message: String) {
        loadingIndicator.stopAnimating()
    }
    
    @objc private func toggleFavorite() {
        interactor?.toggleFavorite()
    }
    
}
