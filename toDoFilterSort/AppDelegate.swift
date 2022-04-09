//
//  AppDelegate.swift
//  toDoFilterSort
//
//  Created by Mavlon on 18/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
       // let vc = UINavigationController(rootViewController: MainVC(nibName: "MainVC", bundle: nil))
        let vc = MainTabBar()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

