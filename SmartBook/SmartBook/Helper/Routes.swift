//
//  Routes.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Routes {
    
    enum StoryboardName: String {
        case main = "Main"
        case authentication = "Authentication"
        case userProfile = "User Profile"
        case userProfileEdit = "User Profile Edit"
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

    private static func makeRootViewController() -> RootViewController {
        return RootViewController()
    }

    private static func makeLoginViewController() -> UIViewController {
        return StoryboardInfo.instantiateVC(
            from: .main,
            identifier: StoryboardInfo.Identifier.authenticationVC
        )
    }

    static func presentMainAppFlow() {
        let rootVC = makeRootViewController()
        setRootViewController(rootVC, transition: .transitionFlipFromRight)
    }

    static func showLoginScreen() {
        let loginVC = makeLoginViewController()
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
