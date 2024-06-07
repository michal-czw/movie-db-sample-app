//
//  MoviesServiceTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

final class MoviesServiceTests: XCTestCase {
    
    var service: MoviesService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        service = MoviesService()
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func test_GivenCorrectData_FetchesMovie() async throws {
        let response = Movie(
            id: 1,
            title: "Title",
            overview: "Overview",
            posterPath: nil,
            releaseDate: "2024-06-07",
            voteAverage: 1,
            voteCount: 1
        )
        
        MockURLProtocol.mockData = try JSONEncoder().encode(response)
        let result = try await service.fetchMovie(id: 1)
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.title, "Title")
    }
    
    func test_GivenEmptyData_FetchMovie_ThrowsError() async throws {
        MockURLProtocol.mockData = try JSONEncoder().encode(Data())
        
        do {
            _ = try await service.fetchMovie(id: 1)
            XCTFail("Error needs to be thrown")
        } catch {}
    }

}
