//
//  Authentication.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 05.02.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import Foundation
import Firebase


protocol AuthenticationProtocol {
    func authenticate(email: String?, password: String?,firstName: String?, lastName: String?, state: AuthState, completion: @escaping (AuthResult) -> Void)
    
}

class Authentication: AuthenticationProtocol {

    func authenticate(email: String?, password: String?,firstName: String?, lastName: String?, state: AuthState , completion: @escaping (AuthResult) -> Void) {
        
        guard Validators.isFIlled(firstName: firstName, lastName: lastName, email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        switch state {
        case .login:
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard let _ = result else {
                    completion(.failure(error!))
                    return
                }
                completion(.sucess)
            }
        case .register:

            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard let _ = result else {
                    completion(.failure(error!))
                    return
                }
                
                let db = Firestore.firestore()
                let id = Auth.auth().currentUser?.uid

                db.collection("users").document(id!).setData([
                    "firstName": firstName!,
                    "lastName": lastName!,
                    "uid": result!.user.uid
                ]) { (error) in
                    if error != nil {
                        completion(.failure(AuthError.serverError))
                    }
                    completion(.sucess)
                }
            }
        }
    }
}
