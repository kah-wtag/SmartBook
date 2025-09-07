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
        static let homeVC = "HomeViewController"
        static let calendarVC = "CalendarViewController"
        static let favoriteVC = "FavoriteViewController"
        static let searchVC = "SearchViewController"
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
    
    private static func makeRootViewController() -> RootViewController {
        RootViewController()
    }
    
    private static func makeAuthenticationVC() -> UIViewController? {
        instantiateVC(from: StoryboardName.main, identifier: Identifier.authenticationVC)
    }
}

extension Routes {
    
    static func rootViewScreen() {
        let rootVC = makeRootViewController()
        setRootViewController(rootVC, transition: .transitionFlipFromRight)
    }
    
    static func showLoginScreen() {
        guard let loginVC = makeAuthenticationVC() else { return }
        setRootViewController(loginVC, transition: .transitionFlipFromLeft)
    }
    
    private static func setRootViewController(_ vc: UIViewController, transition: UIView.AnimationOptions) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: transition,
                          animations: nil)
    }
}
