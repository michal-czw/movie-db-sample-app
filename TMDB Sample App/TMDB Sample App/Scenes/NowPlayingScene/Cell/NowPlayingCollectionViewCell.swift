//
//  NowPlayingCollectionViewCell.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let favoriteButtonSize: CGSize = .init(width: 44, height: 44)
    }
    
    private let posterImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.backgroundColor = .systemGray3
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fallbackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageView.contentMode = .center
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientView: GradientView = {
        let view = GradientView(model: GradientViewModel(
            points: [
                (color: .black.withAlphaComponent(0), location: 0.4),
                (color: .black.withAlphaComponent(0.8), location: 1.0)
            ],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1)
        ))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        button.tintColor = .systemYellow
        button.backgroundColor = .black.withAlphaComponent(0.7)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var viewModel: NowPlayingCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        if let id = viewModel?.id {
            FavoriteChangeset.sharedInstance.removeObserver(self, for: id)
        }
    }
    
    func configure(with viewModel: NowPlayingCellViewModel) {
        FavoriteChangeset.sharedInstance.observe(id: viewModel.id, with: self)
        titleLabel.text = viewModel.title
        setImage(with: viewModel)
    }
    
    private func setImage(with viewModel: NowPlayingCellViewModel) {
        self.viewModel = viewModel
        guard let poster = viewModel.poster else {
            fallbackImageView.isHidden = false
            posterImageView.isHidden = true
            return
        }
        fallbackImageView.isHidden = true
        posterImageView.isHidden = false
        posterImageView.loadImage(url: poster)
        
        let isFavorite = FavoriteChangeset.sharedInstance.isFavorite(id: viewModel.id)
        setUpFavoriteButton(isFavorite: isFavorite)
    }
    
    private func setUpViews() {
        contentView.addSubview(fallbackImageView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        
        contentView.addConstraints([
            fallbackImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fallbackImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.centerYAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constants.favoriteButtonSize.width),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.favoriteButtonSize.height)
        ])
        
    
        clipsToBounds = true
        layer.cornerRadius = 10
        favoriteButton.layer.cornerRadius = Constants.favoriteButtonSize.width / 2
    }
    
    private func setUpFavoriteButton(isFavorite: Bool) {
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "star.fill" : "star"), for: .normal)
    }
    
    @objc private func toggleFavorite() {
        guard let id = viewModel?.id else {
            return
        }
        FavoriteChangeset.sharedInstance.toggleFavorite(id: id)
    }
}

extension NowPlayingCollectionViewCell: FavoriteObserver {
    
    func onFavoriteChange(isFavorite: Bool) {
        setUpFavoriteButton(isFavorite: isFavorite)
    }
    
}
