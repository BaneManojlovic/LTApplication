//
//  APIManager.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

//2.
final class APIManager: BaseAPI {
    
    let kUserTokenHeaderKey = "User-Token"
    
    var baseURL: URL = Config.instance.apiURL
    
    static var `default` = APIManager()
    
    private enum Endpoint {
        static let login = "api/log-in"
        static let signUp = "api/sign-up"
        static let deviceToken = "api/device-token"
    }
    
    typealias APIMessageSuccess = (_ apiMessage: APIMessage?) -> Void
    typealias UserResponseSuccess = (_ user: UserModel?, _ message: String?) -> Void
    
    typealias LoginSuccess = UserResponseSuccess
    func login(
        requestModel: LoginRequestModel,
        success: @escaping LoginSuccess,
        failure: @escaping APIFailure)
    {
        sendPOSTRequest(endpoint: Endpoint.login, model: requestModel, success: { (user: UserModel?, message: String?) in
            success(user, message)
        }, failure: failure)
    }
    
    typealias RegisterSuccess = () -> Void
    func register(
        requestModel: RegisterRequestModel,
        success: @escaping RegisterSuccess,
        failure: @escaping APIFailure)
    {
        sendPOSTRequest(
            endpoint: Endpoint.signUp,
            model: requestModel,
            success: { (_: EmptyResponse?, _) in
                success()
        }, failure: failure)
    }
    
    typealias DeviceTokenSuccess = () -> Void
    func sendFCMToken(
        token: String,
        requestModel: UserFCMTokenRequestModel,
        success: @escaping DeviceTokenSuccess,
        failure: @escaping APIFailure)
    {
        
        sendPOSTRequest(
            endpoint: Endpoint.deviceToken,
            model: requestModel,
            headers: [kUserTokenHeaderKey: token],
            success: { (_: EmptyResponse?, _) in
                success()
        },
            failure: failure)
    }
    
}
