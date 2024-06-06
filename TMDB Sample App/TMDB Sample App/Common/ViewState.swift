//
//  ViewState.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 05/06/2024.
//

import Foundation

enum ViewState<T> {
    
    case loading
    case ready(T)
    case failure(Error)
    
}

extension ViewState {
    
    var isLoading: Bool {
        guard case .loading = self else {
            return false
        }

        return true
    }
    
}
