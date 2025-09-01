//
//  StoryboardIdentifier.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 6/8/25.
//

import UIKit

struct StoryboardInfo {
    
    enum Name: String {
        case main = "Main"
        case authentication = "Authentication"
        case userProfile = "User Profile"
        case userProfileEdit = "User Profile Edit"
        case serviceList = "Service List"
        case healthcareField = "Healthcare Field"
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
        
        static let serviceListVC = "ServiceListViewController"
        static let serviceListCell = "ServiceListTableViewCell"
        
        static let healthcareFieldVC = "HealthcareFieldViewController"
        static let healthcareFieldCell = "HealthcareFieldCell"
    }
    
    static func instantiateVC(from storyboard: Name, identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
}
