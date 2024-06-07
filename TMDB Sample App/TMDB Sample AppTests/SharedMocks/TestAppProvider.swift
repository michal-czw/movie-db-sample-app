//
//  TestAppProvider.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

class TestAppProvider {

    static var instance: MockAppProvider!

    static func initialize() {
        instance = MockAppProvider()
        TMDB.initialize(with: instance)
    }

}

