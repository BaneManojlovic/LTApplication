//
//  UserModel.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import CoreLocation

enum UserType: String, Codable {
    case user
    case sponsor
    case artist
}

struct UserModel: Codable {
    
    private(set) var id: Int
    private(set) var email: String?
    private(set) var firstName: String?
    private(set) var lastName: String?
    private(set) var loginToken: String
    private(set) var type: UserType?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case loginToken
        case type
    }
    
    var isRegistrationCompleted: Bool {
        guard
            firstName != nil,
            lastName != nil
//            birthDate != nil,
//            gender != nil
            else {
                return false
        }
        return true
    }

}
