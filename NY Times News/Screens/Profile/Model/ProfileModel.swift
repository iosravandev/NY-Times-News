//
//  ProfileModel.swift
//  NewYork Times News
//
//  Created by Ravan on 30.11.24.
//

import UIKit
import Foundation

enum ProfileType {
    
    case about
    case termsAndConditions
    case privacyPolicy
    case contactUs
    case darkMode
    case logout
    
    func icon() -> UIImage {
        
        switch self {
        case .about:
            return UIImage(named: "profileInfoIcon") ?? UIImage()
        case .termsAndConditions:
            return UIImage(named: "profileDocIcon") ?? UIImage()
        case .privacyPolicy:
            return UIImage(named: "profilePrivacyIcon") ?? UIImage()
        case .contactUs:
            return UIImage(named: "profilePhoneIcon") ?? UIImage()
        case .darkMode:
            return UIImage(named: "ic_dark") ?? UIImage()
        case .logout:
            return UIImage(named: "profileLogoutIcon") ?? UIImage()
        }
        
    }
    
}

struct ProfileModel {
    
    let title: String
    let description: String
    let type: ProfileType
    
}

struct ProfileEmailViewlModel {
    
    let name: String
    let email: String

}
