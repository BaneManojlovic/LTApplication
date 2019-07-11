//
//  BaseViewController.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD
import PopupDialog

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private var progressHUD: MBProgressHUD?
    
    
    func showProgressHUD() {
        if progressHUD == nil {
            progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            progressHUD?.removeFromSuperViewOnHide = true
        }
    }
    
    func hideProgressHUD() {
        progressHUD?.hide(animated: true)
        progressHUD = nil
    }
}
