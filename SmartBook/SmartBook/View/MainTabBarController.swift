//
//  MainTabBarController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [
            createNavController(vc: HomeViewController(), title: "Home", image: "house"),
            createNavController(vc: CalendarViewController(), title: "Calendar", image: "calendar"),
            createNavController(vc: SearchViewController(), title: "Search", image: "magnifyingglass"),
            createNavController(vc: FavouriteViewController(), title: "Favourite", image: "heart"),
            Router.viewController(
                storyboard: .userProfile,
                identifier: StoryboardInfo.Identifier.userProfileVC,
                title: "User Profile",
                tabImage: "person.crop.circle",
                showSignOut: true
            )
        ]
        
        tabBar.tintColor = UIColor(named: "secondaryTextColor") ?? .black
        tabBar.backgroundColor = .systemBackground
    }
    
    private func loadFromStoryboard(_ storyboard: StoryboardInfo.Name, _ identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
    
    
    private func createNavController(vc: UIViewController, title: String, image: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(systemName: image)
        vc.navigationItem.title = title
        
        let iconColor = UIColor(named: "primaryTextColor") ?? .black
        
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: nil,
            action: nil
        )
        notificationButton.tintColor = iconColor
        
        let signOutButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.right.square"),
            style: .plain,
            target: vc, // or self if in controller
            action: #selector(UserProfileViewController.signOutTapped)
        )

        signOutButton.tintColor = iconColor
        
        if vc is UserProfileViewController {
            vc.navigationItem.rightBarButtonItems = [signOutButton, notificationButton]
        } else {
            vc.navigationItem.rightBarButtonItems = [notificationButton]
        }
        
        return nav
    }
    
    
}

