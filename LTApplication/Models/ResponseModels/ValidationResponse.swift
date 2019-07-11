//
//  ValidationResponse.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

struct ValidationResponse: Decodable {
    var validation: ValidationModel?
}

struct ValidationModel: Decodable {
    
    // MARK: - Email validation
    
    struct EmailValidation: Decodable {
        var isEmpty: String?
        
        var validationMessage: String? {
            return isEmpty?.replace(with: "Email is empty")
        }
    }
    
    // MARK: - PasswordValidation
    
    struct PasswordValidation: Decodable {
        var isEmpty: String?
        var invalid: String?
        
        var validationMessage: String? {
            return isEmpty?.replace(with: "Password field is empty") ?? invalid?.replace(with: "Password is invalid")
        }
    }
    
    // MARK: - Token validation
    
    struct TokenValidation: Decodable {
        var isEmpty: String?
        
        var validationMessage: String? {
            return isEmpty?.replace(with: "Token is empty")
        }
    }
    
    var email: EmailValidation?
    var token: TokenValidation?
    
//    private enum CodingKeys: String, CodingKey {
//        case email
//        case token
//    }
    
    var password: PasswordValidation?
    
    private enum CodingKeys: String, CodingKey {
        case password
    }
    
}

private extension String {
    
    func replace(with translation: String) -> String {
        return translation
    }
}
