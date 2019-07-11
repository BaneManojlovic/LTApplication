//
//  SessionManager+Util.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

extension SessionManager {
    
    @discardableResult
    public func postRequest<P: Encodable>(
        _ url: URLConvertible,
        parameters: P,
        headers: HTTPHeaders? = nil)
        -> DataRequest? {
            
            var originalRequest: URLRequest?
            
            do {
                originalRequest = try URLRequest(url: url, method: .post, headers: headers)
                let encodedURLRequest = try encode(originalRequest!, with: parameters)
                return request(encodedURLRequest)
            } catch {
                return nil
            }
    }
}

private func encode<P: Encodable>(_ urlRequest: URLRequestConvertible, with parameters: P?) throws -> URLRequest {
    var urlRequest = try urlRequest.asURLRequest()
    
    guard let parameters = parameters else { return urlRequest }
    
    let encoder = JSONEncoder()
    
    do {
        let data = try encoder.encode(parameters)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
    } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
    }
    
    return urlRequest
}
