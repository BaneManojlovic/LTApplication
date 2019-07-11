//
//  CustomNotificationEnum.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

enum CustomNotification {
    
    /// Notification when user object is changed in application.
    static let user = Notification.Name("nl.mylermedia.Afterparty.develop.user")
    
    /// Notification when user logs out
    static let userDidLogOut = Notification.Name("nl.mylermedia.Afterparty.develop.userDidLogOut")
}


enum UserInfoKey {
    
    /// Used for mapping UserObjectModel
    static let user = "nl.mylermedia.Afterparty.develop.user"
    
    
}
