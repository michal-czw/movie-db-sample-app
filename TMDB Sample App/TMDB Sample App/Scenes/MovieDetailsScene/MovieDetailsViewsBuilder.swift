//
//  MovieDetailsViewsBuilder.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

enum MovieDetailsViewsBuilder {
    
    static func makePoster(url: URL?) -> AsyncImageView {
        let imageView = AsyncImageView()
        imageView.loadImage(url: url)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }
    
    static func makeTitleLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: UIFont.buttonFontSize)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    static func makeDescriptionLabel(_ description: String) -> UILabel {
        let label = UILabel()
        label.text = description
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        label.numberOfLines = 0
        return label
    }
    
    static func makeInfoLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        label.numberOfLines = 1
        return label
    }
    
}
