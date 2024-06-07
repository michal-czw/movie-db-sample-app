//
//  ProcessInfo+TestModeTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

final class ProcessInfo_TestModeTests: XCTestCase {

    func testTestMode_WhenExecutingTests_ReturnsTrue() {
        XCTAssertTrue(ProcessInfo.processInfo.isTestMode)
    }

}
