//
//  AuthService.swift
//  DevChat
//
//  Created by Gabriel T on 2017-10-04.
//  Copyright © 2017 Gabriel T. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (String?, AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == AuthErrorCode.userNotFound {
                        self.signUpAndLogin(email: email, password: password, onComplete: onComplete)
                    } else {
                        // handle all other errors
                        self.handleFirebaseError(error: error!, onComplete: onComplete)
                    }
                }
            } else {
                onComplete?(nil, user)
            }
        }
    }
    
    private func signUpAndLogin(email: String, password: String, onComplete: Completion?) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleFirebaseError(error: error!, onComplete: onComplete)
            } else {
                if user?.uid != nil {
                    // sign in
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.handleFirebaseError(error: error!, onComplete: onComplete)
                        } else {
                            onComplete?(nil, user)
                        }
                    })
                }
            }
        })
    }
    
    func handleFirebaseError(error: Error, onComplete: Completion?) {
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch (errorCode) {
            case .invalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .wrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email alrady in use.", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }
}























