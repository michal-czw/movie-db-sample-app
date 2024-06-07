//
//  AsyncImageViewTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

final class AsyncImageViewTests: XCTestCase {
    
    private let imageView = AsyncImageView()
    
    override func tearDownWithError() throws {
        MockURLProtocol.mockData = nil
        try super.tearDownWithError()
    }

    func testImageView_WhenImageLoaded_StoresImageInCache() throws {
        MockURLProtocol.mockData = UIColor.red.image().pngData()
        
        let predicate = NSPredicate { any, _ in self.imageView.image != nil }
        imageView.loadImage(url: URL(string: "stubbed")!)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: imageView)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5.0)
        
        switch result {
            case .completed:
            let cachedImage = try XCTUnwrap(TestAppProvider.instance.cache.object(forKey: "stubbed") as? UIImage)
            XCTAssertNotNil(cachedImage)
            XCTAssertNotNil(imageView.image)
            default:
                XCTFail()
        }
    }

}
