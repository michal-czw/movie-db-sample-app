//
//  AppProviding.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 06/06/2024.
//

import Foundation

protocol AppProviding {
    
    var cache: NSCache<NSString, AnyObject> { get }
    var configuration: Configuration? { get }
    
}
