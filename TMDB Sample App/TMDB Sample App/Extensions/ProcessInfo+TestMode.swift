//
//  ProcessInfo+TestMode.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import Foundation

extension ProcessInfo {
    
    var isTestMode: Bool {
        arguments.contains("TEST_MODE")
    }
    
}
