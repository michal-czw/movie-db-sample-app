//
//  AppProvider.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

class AppProvider: AppProviding {
    
    var cache: NSCache<NSString, AnyObject>
    var configuration: Configuration?
    var urlSession: URLSession
    
    init() {
        cache = .init()
        urlSession = .shared
        Task {
            configuration = try await ConfigurationService().fetchConfiguration()
        }
    }
    
}
