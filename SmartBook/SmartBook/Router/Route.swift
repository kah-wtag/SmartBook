//
//  Route.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

enum Route {
    case login
    case signup
    case userProfile
    case notificationCenter
    case main

    var storyboardName: String {
        switch self {
        case .login, .signup: return "Authentication"
        case .userProfile: return "User Profile"
        case .notificationCenter: return "Notification" 
        case .main: return "Main"
        }
    }

    var viewControllerIdentifier: String {
        switch self {
        case .login: return "LoginViewController"
        case .signup: return "SignupViewController"
        case .userProfile: return "UserProfileViewController"
        case .notificationCenter: return "NotificationViewController"
        case .main: return "MainViewController"
        }
    }

    func instantiateViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.viewControllerIdentifier)
    }
}
