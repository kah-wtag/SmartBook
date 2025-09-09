//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

final class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabs()
        delegate = self
        updateNavigation(for: selectedIndex)
    }
    
    private func setupAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clearBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.secondaryText]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .secondaryText
        
        tabBar.tintColor = .secondaryText
        tabBar.backgroundColor = .reverseSecondaryText
    }
    
    private func setupTabs() {
        let items: [(UIViewController, String, String)] = [
            (HomeViewController(), "Home", "house"),
            (CalendarViewController(), "Calendar", "calendar"),
            (ActivityViewController(), "Activity", "calendar.circle.fill"),
            (SearchViewController(), "Search", "magnifyingglass"),
            (Routes.userProfileVC ?? UIViewController(), "Profile", "person.crop.circle")
        ]
        
        viewControllers = items.enumerated().map { _, item in
            let (vc, title, icon) = item
            vc.title = title
            vc.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: 0)
            return vc
        }
    }
    
    private func updateNavigation(for index: Int) {
        guard let currentVC = viewControllers?[index] else { return }
        self.navigationItem.title = currentVC.tabBarItem.title
        
        if index == 4 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.square")?.withTintColor(.secondaryText, renderingMode: .alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(signOutTapped)
            )
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "bell")?.withTintColor(.secondaryText, renderingMode: .alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(notificationTapped)
            )
        }
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        guard let nav = navigationController else { return }
        Routes.showLoginScreen(in: nav)
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigation(for: tabBarController.selectedIndex)
    }
}
