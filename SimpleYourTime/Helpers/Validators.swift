//
//  Validators.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 09.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import Foundation

class Validators {
    static func isFIlled(firstName: String?, lastName: String?, email: String?, password: String?) -> Bool {
        guard !(firstName ?? "").isEmpty,
            !(lastName ?? "").isEmpty,
            !(email ?? "").isEmpty,
            !(password ?? "").isEmpty else {
                return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
