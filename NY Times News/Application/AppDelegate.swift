//
//  AppDelegate.swift
//  NY Times News
//
//  Created by Ravan on 15.12.24.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    struct DefaultsKeys {
        static let isLoggedIn = "isLoggedIn"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            FirebaseApp.configure()
            window = UIWindow(frame: UIScreen.main.bounds)
            
            let isLoggedIn = UserDefaults.standard.bool(forKey: DefaultsKeys.isLoggedIn)
            print("UserDefaults: isLoggedIn = \(isLoggedIn)")
            
            if isLoggedIn {
                let tabBarController = Router.getTabBarVC()
                window?.rootViewController = UINavigationController(rootViewController: tabBarController)
            } else {
                let signInVC = Router.getSignInVC()
                window?.rootViewController = UINavigationController(rootViewController: signInVC)
            }
            
            window?.makeKeyAndVisible()
            return true
    }
    
}
