//
//  DefaultResponse.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

struct DefaultResponse<DataType: Decodable>: Decodable {
    
    private(set) var status: String?
    private(set) var message: String?
    private(set) var data: DataType?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        data = try container.decodeIfPresent(DataType.self, forKey: .data)
    }
}
