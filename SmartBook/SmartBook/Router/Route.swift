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
    case serviceList
    case userProfile
    case main

    var storyboardName: String {
        switch self {
        case .login, .signup:
            return "Authentication"
        case .serviceList:
            return "Service List"
        case .userProfile:
            return "User Profile"
        case .main:
            return "Main"
        }
    }

    var viewControllerIdentifier: String {
        switch self {
        case .login:
            return "LoginViewController"
        case .signup:
            return "SignupViewController"
        case .serviceList:
            return "ServiceListViewController"
        case .userProfile:
            return "UserProfileViewController"
        case .main:
            return "MainViewController"
        }
    }

    func instantiateViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.viewControllerIdentifier)
    }
}
