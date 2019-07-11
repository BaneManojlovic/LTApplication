//
//  ViewController.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/19/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
            loginButton.backgroundColor = .lightGray
            loginButton.layer.cornerRadius = 15
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = UIColor.black.cgColor
            
            signupButton.backgroundColor = .lightGray
            signupButton.layer.cornerRadius = 15
            signupButton.layer.borderWidth = 1
            signupButton.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        print("Login tapped...")
        let loginVC = StoryboardScene.Auth.loginViewController.instantiate()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        print("Signup tapped...")
        let registerVC = StoryboardScene.Auth.registerViewController.instantiate()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

