//
//  RegisterViewModel.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

final class RegisterViewModel {
    
    var email: String?
    var password: String?
    var confirmPassword: String?
    
//    var isOver18: Bool = false
//    var isTermsAndConditionsAccepted: Bool = false
//    var isPrivacyPoliceAccepted: Bool = false
    
    init() { }
    
    // MARK: - Validation
    
    enum ValidationError: Error {
        case emailInvalid
        case passwordShort
        case passwordsDontMatch
        
        var localizedDescription: String {
            switch self {
            case .emailInvalid:
                return "Email is in invalid format!"
            case .passwordShort:
                return "Password is too short!"
            case .passwordsDontMatch:
                return "Passwords don't match!"
            }
        }
    }
    
    func validate() throws {
        if !(email?.isEmailValid() ?? false) { throw ValidationError.emailInvalid }
        if password?.count ?? 0 < 6 { throw ValidationError.passwordShort }
        if password != confirmPassword { throw ValidationError.passwordsDontMatch }
    }
    
    // MARK: - Other methods
    
    func createRegisterRequestModel() -> RegisterRequestModel? {
        guard let email = self.email,
            let password = self.password
            else {
                return nil
        }
        return RegisterRequestModel(email: email, password: password)
    }
}
