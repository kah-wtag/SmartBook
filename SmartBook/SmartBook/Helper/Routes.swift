//
//  Routes.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Routes {}

extension Routes {
    
    struct StoryboardName {
        static let main = "Main"
        static let authentication = "Authentication"
        static let userProfile = "User Profile"
        static let userProfileEdit = "User Profile Edit"
    }
    
    struct Identifier {
        static let authenticationVC = "AuthenticationViewController"
        static let loginVC = "LoginViewController"
        static let signupVC = "SignupViewController"
        static let userProfileVC = "UserProfileViewController"
        static let userProfileEditVC = "UserProfileEditViewController"
    }
}

extension Routes {
    static func instantiateVC<T: UIViewController>(
        from storyboard: String,
        identifier: String
    ) -> T? {
        UIStoryboard(name: storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension Routes {
    static var loginVC: LoginViewController? {
        instantiateVC(from: StoryboardName.main, identifier: Identifier.loginVC)
    }
    
    static var signupVC: SignupViewController? {
        instantiateVC(from: StoryboardName.main, identifier: Identifier.signupVC)
    }
    
    static var userProfileVC: UserProfileViewController? {
        instantiateVC(from: StoryboardName.userProfile, identifier: Identifier.userProfileVC)
    }
    
    static var userProfileEditVC: UserProfileEditViewController? {
        instantiateVC(from: StoryboardName.userProfileEdit, identifier: Identifier.userProfileEditVC)
    }
}

extension Routes {
    
    static func rootViewScreen(in nav: UINavigationController) {
            let rootVC = RootViewController()
            nav.setViewControllers([rootVC], animated: true)
        }
    
    static func showLoginScreen(in nav: UINavigationController) {
            guard let loginVC = instantiateVC(
                from: StoryboardName.main,
                identifier: Identifier.authenticationVC
            ) else { return }
            
            nav.setViewControllers([loginVC], animated: true)
        }
}
