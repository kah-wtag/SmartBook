//
//  Routes.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Routes {
    struct StoryboardName {
        static let authentication = "Authentication"
        static let userProfile = "User Profile"
        static let root = "Dashboard"
    }
    
    struct Identifier {
        static let authenticationVC = "AuthenticationViewController"
        static let loginVC = "LoginViewController"
        static let signupVC = "SignupViewController"
        static let userProfileVC = "UserProfileViewController"
        static let userProfileEditVC = "UserProfileEditViewController"
        static let rootVC = "RootViewController"
    }
}

extension Routes {
    static func instantiateVC<T: UIViewController>(from storyboard: String, identifier: String) -> T? {
        UIStoryboard(name: storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension Routes {
    static var rootVC: RootViewController? {
        instantiateVC(from: StoryboardName.root, identifier: Identifier.rootVC)
    }
    
    static var loginVC: LoginViewController? {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.loginVC)
    }
    
    static var signupVC: SignupViewController? {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.signupVC)
    }
    
    static var authenticationVC: AuthenticationViewController? {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.authenticationVC)
    }
    
    
    static var userProfileVC: UserProfileViewController? {
        instantiateVC(from: StoryboardName.userProfile, identifier: Identifier.userProfileVC)
    }
    
    static var userProfileEditVC: UserProfileEditViewController? {
        instantiateVC(from: StoryboardName.userProfile, identifier: Identifier.userProfileEditVC)
    }
}

extension Routes {
    static func displayRootScreen() {
        guard let rootVC = rootVC
        else {
            return
        }
        displayScreen(rootVC)
    }
    
    static func displayLoginScreen() {
        guard let loginVC = authenticationVC
        else {
            return
        }
        displayScreen(loginVC, hideNavigationBar: true)
    }
    
    static func displayScreen(_ viewController: UIViewController, hideNavigationBar: Bool = false) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            return
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.setNavigationBarHidden(hideNavigationBar, animated: false)
        
        if !hideNavigationBar {
            setupNavBar(for: navController)
        }
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    static func setupNavBar(for nav: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondaryBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.secondaryText]
        appearance.shadowColor = UIColor.primaryText
        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.compactAppearance = appearance
        nav.navigationBar.tintColor = .secondaryText
    }
    
}
