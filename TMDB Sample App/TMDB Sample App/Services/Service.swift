//
//  Service.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import UIKit

enum ServiceConfiguration {
    
    static let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    static let apiVersion = "3"
    
}

enum ServiceError: Error {
    
    case invalidRequest
    
}

protocol Service {
    
    var urlSession: URLSession { get }
    
}

extension Service {
    
    func fetchRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let (data, _) = try await urlSession.data(for: request)
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
}
