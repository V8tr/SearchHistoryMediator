//
//  AppDelegate.swift
//  Mediator
//
//  Created by Vadim Bulavin on 1/29/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let repository = InMemoryHistoryRepository()
        repository.addSearchTerm("1")
        repository.addSearchTerm("2")
        repository.addSearchTerm("3")

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: SampleViewController(historyRepository: repository))
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

