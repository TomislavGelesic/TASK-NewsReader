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
        
        let dependencies = NewsDependencies(repository: NewsRepositoryImpl(), dataSource: nil)
        let vm = NewsViewModel(dependencies: dependencies)
        let vc = NewsViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

