//
//  LoginViewModel.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    var email: String?
    var password: String?
    
    init() { }
    
    // MARK: - Other methods
    
    func createLoginRequestModel() -> LoginRequestModel? {
        guard let email = email,
            let password = password
            else {
                return nil
        }
        return LoginRequestModel(email: email, password: password)
    }
    
    enum ValidationError: Error {
        
        case emailEmpty
        case passwordEmpty
        case emailInvalid
        
        var localizedDescription: String {
            switch self {
            case .emailEmpty:
                return "Email field is empty"
            case .passwordEmpty:
                return "Password field is empty"
            case .emailInvalid:
                return "Email is not valid"
            }
        }
    }
    
    func validate() throws {
        if email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" == "" { throw ValidationError.emailEmpty }
        if !(email?.isEmailValid() ?? false) { throw ValidationError.emailInvalid }
        if password?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" == "" { throw ValidationError.passwordEmpty }
    }

}
