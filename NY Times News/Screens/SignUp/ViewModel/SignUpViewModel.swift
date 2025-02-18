//
//  SignUpVM.swift
//  NewYork Times News
//
//  Created by Ravan on 19.11.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel {
    
    var name: String?
    var surname: String?
    var email: String?
    var password: String?
    
    var onSignUpSuccess: (() -> Void)?
    var onSignUpFailure: ((Error) -> Void)?
    var onStateChanged: (() -> Void)?
    
    func signUp() {
        guard fieldsAreValid() else {
            onSignUpFailure?(NSError(domain: "Local", code: 400, userInfo: [NSLocalizedDescriptionKey: "All fields must be filled and valid."]))
            return
        }
        
        Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] authResult, error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.onSignUpFailure?(error)
                return
            }
            self.onSignUpSuccess?()
            
            guard let userId = authResult?.user.uid else {
                self.onSignUpFailure?(NSError(domain: "Local", code: 500, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users").document(userId).setData([
                "name": name,
                "email": email
            ]) { error in
                if let error = error {
                    self.onSignUpFailure?(error)
                } else {
                    self.onSignUpSuccess?()
                }
            }
        }
    }
    
    func fieldsAreValid() -> Bool {
        guard let email = email, let password = password, let name = name, let surname = surname,
              !email.isEmpty, !password.isEmpty, !name.isEmpty, !surname.isEmpty, isValidEmail(email) else {
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func updateState(name: String?, surname: String?, email: String?, password: String?) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        onStateChanged?()
    }
    
}
