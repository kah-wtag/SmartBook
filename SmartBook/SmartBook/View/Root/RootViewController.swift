//
//  RootViewController.swift
//  WelldevTraining SmartBookMainTabbar
//
//  Created by Md. Kamrul Hasan on 21/8/25.
//

//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 21/8/25.
//

import UIKit

final class RootViewController: UIViewController {
    
    private let mainTabBarController = MainTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        embedTabBar()
        mainTabBarController.delegate = self
        updateNavigation(for: mainTabBarController.selectedIndex)
    }
    
    private func embedTabBar() {
        addChild(mainTabBarController)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.view.frame = view.bounds
        mainTabBarController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTabBarController.didMove(toParent: self)
    }
    
    private func updateNavigation(for index: Int) {
        if let currentVC = mainTabBarController.selectedViewController {
            navigationItem.title = currentVC.title
        }
        navigationItem.rightBarButtonItems = nil
        
        if index == 4 {
            let signOutButton = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.square"),
                style: .plain,
                target: self,
                action: #selector(signOutTapped)
            )
            signOutButton.tintColor = UIColor(named: "secondaryTextColor")
            navigationItem.rightBarButtonItem = signOutButton
        } else {
            let notificationButton = UIBarButtonItem(
                image: UIImage(systemName: "bell"),
                style: .plain,
                target: self,
                action: #selector(notificationTapped)
            )
            notificationButton.tintColor = UIColor(named: "secondaryTextColor")
            navigationItem.rightBarButtonItem = notificationButton
        }
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        Router.showLoginScreenWithTransition()
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigation(for: tabBarController.selectedIndex)
    }
}
