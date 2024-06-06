//
//  GradientView.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

class GradientView: UIView {

    convenience init(model: GradientViewModel) {
        self.init(frame: .zero)
        configure(with: model)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func configure(with model: GradientViewModel) {
        prepareForReuse()
        layer.addSublayer(buildGradient(model))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.last?.frame = bounds
    }

    private func prepareForReuse() {
        layer.sublayers?.removeAll()
    }

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func buildGradient(_ model: GradientViewModel) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = model.colors
        layer.locations = model.locations
        layer.startPoint = model.startPoint
        layer.endPoint = model.endPoint
        layer.type = model.type
        layer.frame = bounds
        return layer
    }

}

struct GradientViewModel {

    typealias Point = (color: UIColor, location: Float)

    let locations: [NSNumber]
    let colors: [CGColor]

    var startPoint: CGPoint
    var endPoint: CGPoint
    var type: CAGradientLayerType

    init(
        points: [Point],
        startPoint: CGPoint,
        endPoint: CGPoint,
        type: CAGradientLayerType = .axial
    ) {
        self.colors = points.map(\.color.cgColor)
        self.locations = points.map { NSNumber(value: $0.location) }

        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type
    }

}
