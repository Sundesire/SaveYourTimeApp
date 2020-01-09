//
//  AuthError.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 09.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Неправильный формат email", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        }
    }
}
