//
//  UserFCMTokenRequestModel.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

struct UserFCMTokenRequestModel: RequestModel {
    
    var oldToken: String?
    var deviceToken: String
    
    init(oldToken: String?, deviceToken: String) {
        self.oldToken = oldToken
        self.deviceToken = deviceToken
    }
    
    private enum CodingKeys: String, CodingKey {
        case oldToken = "oldDeviceToken"
        case deviceToken
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(oldToken, forKey: .oldToken)
        try container.encode(deviceToken, forKey: .deviceToken)
    }
}
