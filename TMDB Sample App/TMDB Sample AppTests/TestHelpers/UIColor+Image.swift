//
//  UIColor+Image.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import UIKit

extension UIColor {
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
}
