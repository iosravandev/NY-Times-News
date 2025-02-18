//
//  Router.swift
//  NewYork Times News
//
//  Created by Ravan on 22.11.24.


import UIKit

class Router {
    
    private init() {}
    
    static func getSignInVC() -> SignInViewController {
        return SignInViewController()
    }
    
    static func getSignUpVC() -> SignUpViewController {
        return SignUpViewController()
    }
    
    static func getTabBarVC() -> TabBarViewController {
        return TabBarViewController()
    }
    
    static func presentSignIn(on presenter: UIViewController) {
        let signInVC = getSignInVC()
        presenter.dismiss(animated: true) {
            presenter.present(signInVC, animated: true, completion: nil)
        }
    }
    
    static func pushViewController(_ viewController: UIViewController, on push: UIViewController) {
        if let navigationController = push.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Navigation error for \(type(of: viewController))")
        }
    }
    
    static func pushDetailedAboutViewController(on push: UIViewController) {
        pushViewController(DetailedAboutViewController(), on: push)
    }
    
    static func pushDetailedTermsViewController(on push: UIViewController) {
        pushViewController(DetailedTermsViewController(), on: push)
    }
    
    static func pushDetailedPrivacyViewController(on push: UIViewController) {
        pushViewController(DetailedPrivacyViewController(), on: push)
    }
    
    static func pushDetailedContactUsViewController(on push: UIViewController) {
        pushViewController(DetailedContactUsViewController(), on: push)
    }
    
    static func pushDetailedDarkLightModeViewController(on push: UIViewController) {
        pushViewController(DetailedDarkLightModeViewController(), on: push)
    }
    
}
