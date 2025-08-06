//
//  StoryboardIdentifier.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 6/8/25.
//

import Foundation
import UIKit

struct StoryboardInfo {
    
    enum Name: String {
        case main = "Main"
        case authentication = "Authentication"
        case userProfile = "User Profile"
    }
    
    struct Identifier {
        static let authenticationVC = "AuthenticationViewController"
        static let loginVC = "LoginViewController"
        static let signupVC = "SignupViewController"
        static let userProfileVC = "UserProfileViewController"
        static let homeVC = "HomeViewController"
        static let calendarVC = "CalendarViewController"
        static let favoriteVC = "FavoriteViewController"
        static let searchVC = "SearchViewController"
    }
}

extension StoryboardInfo {
    static func viewController(from storyboard: Name, identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
}
