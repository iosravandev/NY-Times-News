//
//  TabbarView.swift
//  NewYork Times News
//
//  Created by Ravan on 27.11.24.
//

import UIKit
import Foundation

class TabBarViewController: UITabBarController {
    
    let image = UIImage(named: "tabbar1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tabbar1"), selectedImage: UIImage(named: "tabbar1Selected"))
        homeVC.tabBarItem.tag = 0
        
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tabbar1"), selectedImage: UIImage(named: "tabbar1"))
        exploreVC.tabBarItem.tag = 1
        
        let saveVC = SaveViewController()
        saveVC.tabBarItem = UITabBarItem(title: "Save", image: UIImage(named: "tabbar1"), selectedImage: UIImage(named: "tabbar1"))
        saveVC.tabBarItem.tag = 2
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tabbar1"), selectedImage: UIImage(named: "tabbar1"))
        profileVC.tabBarItem.tag = 3
        
        viewControllers = [homeVC, exploreVC, saveVC, profileVC]
    }
    
}
