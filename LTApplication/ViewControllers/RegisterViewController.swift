//
//  RegisterViewController.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextFielad: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    
    private var model = RegisterViewModel()
    
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
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            model.email = sender.text
        case enterPasswordTextFielad:
            model.password = sender.text
        case repeatPasswordTextField:
            model.confirmPassword = sender.text
        default:
            break
        }
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            model.email = sender.text
        case enterPasswordTextFielad:
            model.password = sender.text
        case repeatPasswordTextField:
            model.confirmPassword = sender.text
        default:
            break
        }
    }
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        print("Submit tapped...")
        view.endEditing(true)
        do {
            try model.validate()
            callRegisterAPI()
        } catch let error as RegisterViewModel.ValidationError {
            debugPrint(error.localizedDescription)
//            handleValidationError(error)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // MARK: - Private functions
    
    @objc private func callRegisterAPI() {
        guard let requestModel = model.createRegisterRequestModel() else {
            debugPrint("Unable to create request model")
            return
        }
        showProgressHUD()
        APIManager.default.register(
            requestModel: requestModel,
            success: { [weak self] in
                self?.hideProgressHUD()
                let activateVC = StoryboardScene.Auth.activateAccountViewController.instantiate()
                activateVC.loginRequest = LoginRequestModel(from: requestModel)
                self?.navigationController?.pushViewController(activateVC, animated: true)
        },
        failure: { [weak self] error in
                guard let strongSelf = self else { return }
                if case let .validation(validationError) = error {
                    let message = validationError.email?.validationMessage ??
                    validationError.password?.validationMessage
             //       strongSelf.showDialog(message: message, handler: nil)
                } else {
//                    strongSelf.handleAPIError(error, target: strongSelf, selector: #selector(strongSelf.callRegisterAPI))
                }
        })
    }
}
