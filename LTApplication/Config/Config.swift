//
//  Config.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

class Config {
    
    static var instance = Config()
    
    private init() { }
    
    var example: String {
        #if DEVELOP
            return "DEBUG test"
        #elseif BETA
            return "BETA test"
        #else
            return "RELEASE test"
        #endif
    }
    
    var apiURL: URL {
        let urlString: String
        #if DEVELOP
        urlString = "https://joinin-test.eemaginedev.com/"
        #elseif BETA
        urlString = "https://joinin-test.eemaginedev.com/"
        #else
        urlString = "https://joinin-test.eemaginedev.com/"
        #endif
        return URL(string: urlString)!
    }
}
