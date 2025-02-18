//
//  ProfileViewModel.swift
//  NewYork Times News
//
//  Created by Ravan on 30.11.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel {
    
    var userName: String?
    var userEmail: String?
    
    var onDataUpdated: (() -> Void)?
    
    var items: [ProfileModel] = [
        
        ProfileModel(
            title: "About",
            description: "",
            type: .about),
        
        ProfileModel(
            title: "Terms and Conditions",
            description: "",
            type: .termsAndConditions),
        
        ProfileModel(
            title: "Privacy Policy",
            description: "",
            type: .privacyPolicy),
        
        ProfileModel(
            title: "Contact us",
            description: "",
            type: .contactUs),
        
        ProfileModel(
            title: "Dark Mode",
            description: "",
            type: .darkMode),
        
        ProfileModel(
            title: "Logout",
            description: "",
            type: .logout)
        
    ]
    
    init() {
        fetchUserData()
    }
    
    private func fetchUserData() {
        
        if let user = Auth.auth().currentUser {
            self.userEmail = user.email
            
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { snapshot, error in
                if let data = snapshot?.data(), error == nil {
                    self.userName = data["name"] as? String
                    self.onDataUpdated?()
                }
            }
        }
    }
}
