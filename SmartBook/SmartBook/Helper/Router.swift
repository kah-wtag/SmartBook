//
//  Route.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Router {
    
    static func viewController(
        storyboard: StoryboardInfo.Name,
        identifier: String,
        title: String,
        tabImage: String,
        showSignOut: Bool = false
    ) -> UINavigationController {
        let vc = StoryboardInfo.viewController(from: storyboard, identifier: identifier)
        vc.navigationItem.title = title
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(systemName: tabImage)
        
        let iconColor = UIColor(named: "primaryTextColor") ?? .black
        
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: nil,
            action: nil
        )
        notificationButton.tintColor = iconColor
        
        if showSignOut {
            let signOutButton = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.square"),
                style: .plain,
                target: nil,
                action: nil
            )
            signOutButton.tintColor = iconColor
            vc.navigationItem.rightBarButtonItems = [signOutButton, notificationButton]
        } else {
            vc.navigationItem.rightBarButtonItem = notificationButton
        }
        
        return nav
    }
    
    static func showMainTabBar(from presenter: UIViewController) {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        presenter.present(tabBar, animated: true)
    }
}
