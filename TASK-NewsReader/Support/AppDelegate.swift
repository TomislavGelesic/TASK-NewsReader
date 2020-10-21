//
//  AppDelegate.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainScreen = NewsTableViewController()
        
        let navigationController = UINavigationController(rootViewController: mainScreen)
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

   


}

