//
//  MockURLProtocol.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var mockData: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
}
