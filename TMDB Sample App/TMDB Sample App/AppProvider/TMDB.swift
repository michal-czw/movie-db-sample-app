//
//  TMDB.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

enum TMDB {

    static func initialize(with appProvider: AppProviding) {
        self.appProvider = appProvider
    }

    private(set) static var appProvider: AppProviding!

}
