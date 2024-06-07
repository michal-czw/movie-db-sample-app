//
//  MockAppProvider.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import Foundation
@testable import TMDB_Sample_App

class MockAppProvider: AppProviding {
    
    var cache: NSCache<NSString, AnyObject>
    var configuration: Configuration?
    var urlSession: URLSession
    
    init() {
        self.cache = .init()
        self.configuration = Configuration(images: .init(baseUrl: URL(string: "https://images.mock")!))
        
        URLProtocol.registerClass(MockURLProtocol.self)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses?.insert(MockURLProtocol.self, at: 0)
        urlSession = URLSession(configuration: configuration)
    }
    
}
