//
//  main.swift
//  TMDB Sample App
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import UIKit

App.start()

private class App {

    private class var delegateClassName: String {
        ProcessInfo.processInfo.isTestMode
            ? NSStringFromClass(TestAppDelegate.self)
            : NSStringFromClass(AppDelegate.self)
    }

    fileprivate class func start() {
        UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            nil,
            delegateClassName
        )
    }

}

private class TestAppDelegate: AppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }
    
}
