//
//  SignInVM.swift
//  NewYork Times News
//
//  Created by Ravan on 19.11.24.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
    
    var email: String?
    var password: String?
    
    var isSignInEnabled: Bool {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty, isValidEmail(email) else {
            return false
        }
        return true
    }
    
    var onSignInSuccess: (() -> Void)?
    var onSignInFailure: ((Error) -> Void)?
    var onStateChanged: (() -> Void)?
    
    func signIn(email: String?, password: String?) {
        self.email = email
        self.password = password
        
        guard fieldsAreValid() else {
            onSignInFailure?(NSError(domain: "Local", code: 400, userInfo: [NSLocalizedDescriptionKey: "Email or password cannot be empty or invalid."]))
            return
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            if let error = error {
                self?.onSignInFailure?(error)
                return
            }
            UserDefaults.standard.set(true, forKey: AppDelegate.DefaultsKeys.isLoggedIn)
            UserDefaults.standard.synchronize()
            self?.onSignInSuccess?()
        }
    }
    
    func fieldsAreValid() -> Bool {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty, isValidEmail(email) else {
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func updateState(email: String?, password: String?) {
        self.email = email
        self.password = password
        onStateChanged?()
    }
}

