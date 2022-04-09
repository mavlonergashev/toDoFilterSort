//
//  MainTabBar.swift
//  toDoFilterSort
//
//  Created by Mavlon on 23/02/22.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = MainVC(nibName: "MainVC", bundle: nil)
        let navVC1 = UINavigationController(rootViewController: vc1)
        let tabBarItem1 = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), selectedImage: nil)
        navVC1.tabBarItem = tabBarItem1
        
        let vc2 = AlertVC(nibName: "AlertVC", bundle: nil)
        let navVC2 = UINavigationController(rootViewController: vc2)
        let tabBarItem2 = UITabBarItem(title: "Alert", image: UIImage(systemName: "circle"), selectedImage: nil)
        navVC2.tabBarItem = tabBarItem2

        viewControllers = [navVC1,navVC2]
    }


}
