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
        static let smartServices = "Smart Services"
        static let smartServiceFields = "Smart Service Fields"
        static let serviceProvider = "Service Provider"
        static let serviceProviderProfile = "Service Provider Profile"
        static let bookingForm = "Booking Form"
    }
    
    struct Identifier {
        static let authenticationVC = "AuthenticationViewController"
        static let loginVC = "LoginViewController"
        static let signupVC = "SignupViewController"
        static let userProfileVC = "UserProfileViewController"
        static let userProfileEditVC = "UserProfileEditViewController"
        static let rootVC = "RootViewController"
        static let smartServicesVC = "SmartServicesViewController"
        static let smartServiceCell = "SmartServiceTableViewCell"
        static let smartServiceFieldsVC = "SmartServiceFieldsViewController"
        static let smartServiceFieldCell = "SmartServiceFieldCell"
        static let serviceProviderVC = "ServiceProviderViewController"
        static let serviceProviderCell = "ServiceProviderCell"
        static let sericeProviderProfileVC = "ServiceProviderProfileViewController"
        static let bookingFormVC = "BookingFormViewController"
        static let bookedFormVC = "BookedFormViewController"
        
    }
}

extension Routes {
    static func instantiateVC<T: UIViewController>(from storyboard: String, identifier: String) -> T {
        guard let vc = UIStoryboard(name: storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate \(identifier) from storyboard: \(storyboard)")
        }
        return vc
    }
}

extension Routes {
    static var rootVC: RootViewController {
        instantiateVC(from: StoryboardName.root, identifier: Identifier.rootVC)
    }
}

extension Routes {
    static var loginVC: LoginViewController {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.loginVC)
    }
    
    static var signupVC: SignupViewController {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.signupVC)
    }
    
    static var authenticationVC: AuthenticationViewController {
        instantiateVC(from: StoryboardName.authentication, identifier: Identifier.authenticationVC)
    }
}

extension Routes {
    static var userProfileVC: UserProfileViewController {
        instantiateVC(from: StoryboardName.userProfile, identifier: Identifier.userProfileVC)
    }
    
    static var userProfileEditVC: UserProfileEditViewController {
        instantiateVC(from: StoryboardName.userProfile, identifier: Identifier.userProfileEditVC)
    }
}

extension Routes {
    static var smartServicesVC: SmartServicesViewController {
        instantiateVC(from: StoryboardName.smartServices, identifier: Identifier.smartServicesVC)
    }
    
    static var smartServiceFieldsVC: SmartServiceFieldsViewController {
        instantiateVC(from: StoryboardName.smartServiceFields, identifier: Identifier.smartServiceFieldsVC)
    }
}

extension Routes {
    static var serviceProviderVC: ServiceProviderViewController {
        instantiateVC(from: StoryboardName.serviceProvider, identifier: Identifier.serviceProviderVC)
    }
    
    static var serviceProviderProfileVC: ServiceProviderProfileViewController {
        instantiateVC(from: StoryboardName.serviceProviderProfile, identifier: Identifier.sericeProviderProfileVC)
    }
}

extension Routes {
    static var bookingFormVC: BookingFormViewController {
        instantiateVC(from: StoryboardName.bookingForm, identifier: Identifier.bookingFormVC)
    }
    
    static var bookedFormVC: BookedFormViewController {
        instantiateVC(from: StoryboardName.bookingForm, identifier: Identifier.bookedFormVC)
    }
}

extension Routes {
    static func displayRootScreen() {
        displayScreen(rootVC)
    }
    
    static func displayLoginScreen() {
        displayScreen(authenticationVC, hideNavigationBar: true)
    }
    
    static func displayScreen(_ viewController: UIViewController, hideNavigationBar: Bool = false) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
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
