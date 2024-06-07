//
//  AsyncImageView.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import UIKit

class AsyncImageView: UIImageView {
    
    private var sourceUrl: URL?
    private var dataTask: URLSessionDataTask?
    
    func loadImage(url: URL?) {
        guard sourceUrl != url || image == nil else { return }
        
        dataTask?.cancel()
        dataTask = nil
        image = nil
        sourceUrl = url
        
        guard let url else { return }
        
        if let cachedImage = TMDB.appProvider.cache.object(forKey: url.absoluteString as NSString) as? UIImage {
            image = cachedImage
            return
        }
        
        dataTask = TMDB.appProvider.urlSession.dataTask(with: url) { [weak self] data, _, _ in
            guard let self else { return }
            
            guard let data, let image = UIImage(data: data) else {
                self.sourceUrl = nil
                DispatchQueue.main.async {
                    self.image = nil
                }
                return
            }
            
            DispatchQueue.main.async {
                TMDB.appProvider.cache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        dataTask?.resume()
    }
}
