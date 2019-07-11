//
//  LoginRequestModel.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

struct LoginRequestModel: RequestModel {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init(from registerModel: RegisterRequestModel) {
        self.email = registerModel.email
        self.password = registerModel.password
    }
    
    private enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
}
