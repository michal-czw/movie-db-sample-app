//
//  ViewStateTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

final class ViewStateTests: XCTestCase {
    
    private enum MockError: Error {
        case mockError
    }

    func testIsLoading_WhenViewStateIsLoading_ReturnsTrue() {
        XCTAssertTrue(ViewState<[Any]>.loading.isLoading)
        XCTAssertFalse(ViewState.ready([]).isLoading)
        XCTAssertFalse(ViewState<[Any]>.failure(MockError.mockError).isLoading)
    }

}
