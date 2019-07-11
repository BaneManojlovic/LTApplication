//
//  LoginViewController.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit
import FirebaseInstanceID

class LoginViewController: BaseViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    
    private var model = LoginViewModel()
    
    // MARK: - Licycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        submitButton.backgroundColor = .lightGray
        submitButton.layer.cornerRadius = 15
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Actions
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        print("Submit button tapped...")
        view.endEditing(true)
        do {
            try model.validate()
            callLoginAPI()
        } catch let error as LoginViewModel.ValidationError {
            debugPrint(error.localizedDescription)
//            handleValidationError(error)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    @IBAction func emailDidEndEditing(_ sender: UITextField) {
        model.email = sender.text
    }
    
    @IBAction func passwordDidEndEditing(_ sender: UITextField) {
        model.password = sender.text
    }
    
    // MARK: - Private methods
    
    @objc private func callLoginAPI() {
        guard let loginRequest = model.createLoginRequestModel() else {
            debugPrint("ERROR: No login request")
            return
        }
        showProgressHUD()
        APIManager.default.login(
            requestModel: loginRequest,
            success: loginSuccess,
            failure: { [weak self] error in
      //          self?.loginFailure(error, .facebook)
        })
    }
    
    private lazy var loginSuccess: (_ userModel: UserModel?, _ message: String?) -> Void = { [weak self]
        (user, message) in
        
        guard let strongSelf = self else { return }
        strongSelf.hideProgressHUD()
        guard let user = user else {
//            strongSelf.showDialog(message: message ?? L10n.errorMsgUnableToLogIn, handler: nil)
            print("Unable to login")
            return
        }
        
        if user.isRegistrationCompleted {
            
            // Send token to server
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
            strongSelf.dismiss(animated: true, completion: nil)
        } else {
            let profileVC = StoryboardScene.Auth.homeViewController.instantiate()
            strongSelf.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    private func callUpdateDeviceToken(userToken: String) {
        
        InstanceID.instanceID().instanceID { (result, error) in
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
        }
    }
}
