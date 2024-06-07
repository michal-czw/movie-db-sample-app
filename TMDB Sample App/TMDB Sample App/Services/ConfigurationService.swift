//
//  ConfigurationService.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

protocol ConfigurationProvidingService: Service {
    func fetchConfiguration() async throws -> Configuration
}

struct ConfigurationService: ConfigurationProvidingService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = TMDB.appProvider.urlSession) {
        self.urlSession = urlSession
    }
    
    func fetchConfiguration() async throws -> Configuration {
        let endpoint = Endpoint(
            path: "/\(ServiceConfiguration.apiVersion)/configuration"
        )
        
        guard let request = endpoint.urlRequest else {
            throw ServiceError.invalidRequest
        }
        
        return try await fetchRequest(request)
    }
    
}
