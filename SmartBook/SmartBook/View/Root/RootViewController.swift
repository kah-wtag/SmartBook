//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.

import UIKit

final class RootViewController: UITabBarController {
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        mainTabBar.delegate = self
        updateNavigation(for: selectedIndex)
    }
    
    private func setupAppearance() {
        configureNavBar()
        configureTabBar()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clearBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.secondaryText]
        let borderColor = UIColor.lightGray
        let borderImage = UIImage(color: borderColor, size: CGSize(width: 1, height: 1))
        navBarAppearance.shadowImage = borderImage
        navBarAppearance.shadowColor = borderColor
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .secondaryText
    }
    
    private func configureTabBar() {
        mainTabBar.tintColor = .secondaryText
        mainTabBar.unselectedItemTintColor = .primaryText
        mainTabBar.backgroundColor = .reverseSecondaryText
        setupTabs()
    }
    
    private func setupTabs() {
        let items: [(UIViewController, String, String)] = [
            (ServiceListViewController(), "Home", "house"),
            (CalendarViewController(), "Calendar", "calendar"),
            (ActivityViewController(), "Activity", "calendar.circle.fill"),
            (SearchViewController(), "Search", "magnifyingglass"),
            (Routes.userProfileVC ?? UIViewController(), "Profile", "person.crop.circle")
        ]
        
        viewControllers = items.map { vc, title, icon in
            vc.tabBarItem = UITabBarItem(title: title,
                                         image: UIImage(systemName: icon),
                                         tag: 0)
            return vc
        }
    }
    
    private func updateNavigation(for index: Int) {
        guard let currentVC = selectedViewController else { return }
        navigationItem.title = currentVC.tabBarItem.title
        if selectedIndex == 4 {
            addSignOutButton()
        } else {
            addNotificationButton()
        }
    }
    
    private func addNotificationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bell")?.withTintColor(.secondaryText, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(notificationTapped)
        )
    }
    
    private func addSignOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.right.square")?.withTintColor(.secondaryText, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        guard let nav = navigationController else { return }
        Routes.showLoginScreen(in: nav)
    }
}

extension RootViewController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateNavigation(for: selectedIndex)
    }
}
extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
