//
//  ActivateAccountViewController.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class ActivateAccountViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var checkEmailLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var openApplicationButton: UIButton!
    
    // MARK: - Properties
    
    var loginRequest: LoginRequestModel?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions

    @IBAction func resendButtonTapped(_ sender: Any) {
        callResendAPI()
    }
    
    @IBAction func openApplicationButtonTapped(_ sender: Any) {
        callLoginAPI()
    }
    
    // MARK: - Private methods
    @objc private func callLoginAPI() {
        guard let loginRequest = loginRequest else {
            debugPrint("ERROR: No login request")
            return
        }
        APIManager.default.login(
            requestModel: loginRequest,
            success: { [weak self] (user, message) in
                
                guard let strongSelf = self else { return }
                guard let user = user else {
                   // strongSelf.showDialog(message: message ?? "ERROR: Unable to login", handler: nil)
                    print("ERROR: Unable to login")
                    return
                }
                
                if user.isRegistrationCompleted {
                    
                    strongSelf.callUpdateDeviceToken(userToken: user.loginToken)
                    
                    do {
                        try DatabaseMapper.saveUser(user)
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                    strongSelf.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: CustomNotification.user, object: nil,
                                                        userInfo: [UserInfoKey.user: user])
                    })
                } else {
//                    let profileVC = StoryboardScene.Login.profileViewController.instantiate()
//                    profileVC.user = user
//                    profileVC.origin = .activateAccount
//                    strongSelf.navigationController?.pushViewController(profileVC, animated: true)
                }
            },   failure: { [weak self] error in
                guard let strongSelf = self else { return }
                
        })
    }
    
    private func callUpdateDeviceToken(userToken: String) {
        
    /*    InstanceID.instanceID().instanceID { (result, error) in
            if error == nil, let fcmToken = result?.token {
                let tokenRequestModel = UserFCMTokenRequestModel(oldToken: nil, deviceToken: fcmToken)
                APIManager.default.sendFCMToken(
                    token: userToken,
                    requestModel: tokenRequestModel,
                    success: {
                        // Save FCM Token to DatabaseMapper
                        DatabaseMapper.saveFCMToken(fcmToken)
                }, failure: { _ in })
            }
        }*/
    }
    
    @objc private func callResendAPI() {
        
    }
}
