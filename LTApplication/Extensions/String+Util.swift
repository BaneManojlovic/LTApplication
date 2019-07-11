//
//  String+Util.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

extension String {
    
    func isEmailValid() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive) {
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        } else {
            return false
        }
    }
}
