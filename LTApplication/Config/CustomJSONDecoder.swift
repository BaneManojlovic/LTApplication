//
//  CustomJSONDecoder.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

class CustomJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }()
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
