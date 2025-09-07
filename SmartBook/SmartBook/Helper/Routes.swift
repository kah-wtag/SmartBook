//
//  Routes.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Routes {
    
    struct StoryboardName {
        let main = "Main"
        let authentication = "Authentication"
        let userProfile = "User Profile"
        let userProfileEdit = "User Profile Edit"
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
    
    static let storyboardName = StoryboardName()
    
    static func instantiateVC(from storyboard: String, identifier: String) -> UIViewController {
        UIStoryboard(name: storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: identifier)
    }
    
    static var loginVC: LoginViewController? {
        instantiateVC(from: storyboardName.main, identifier: Identifier.loginVC) as? LoginViewController
    }
    
    static var signupVC: SignupViewController? {
        instantiateVC(from: storyboardName.main, identifier: Identifier.signupVC) as? SignupViewController
    }
    
    static var userProfileVC: UserProfileViewController? {
        instantiateVC(from: storyboardName.userProfile, identifier: Identifier.userProfileVC) as? UserProfileViewController
    }
    
    static var userProfileEditVC: UserProfileEditViewController? {
        instantiateVC(from: storyboardName.userProfileEdit, identifier: Identifier.userProfileEditVC) as? UserProfileEditViewController
    }
    
    
    private static func makeRootViewController() -> RootViewController {
        RootViewController()
    }
    
    private static func makeAuthenticationVC() -> UIViewController {
        instantiateVC(from: storyboardName.main, identifier: Identifier.authenticationVC)
    }
    
    static func rootViewScreen() {
        let rootVC = makeRootViewController()
        setRootViewController(rootVC, transition: .transitionFlipFromRight)
    }
    
    static func showLoginScreen() {
        let loginVC = makeAuthenticationVC()
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
