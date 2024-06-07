//
//  TMDBTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import Foundation
import XCTest

@objc(TMDBTests)
class TMDBTests: NSObject, XCTestObservation {
    
    override init() {
        super.init()
        XCTestObservationCenter.shared.addTestObserver(self)
    }

    func testCaseWillStart(_ testCase: XCTestCase) {
        TestAppProvider.initialize()
    }
    
}
