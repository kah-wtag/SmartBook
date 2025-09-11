//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.

import UIKit

final class RootViewController: UITabBarController {
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    private enum Tab: Int, CaseIterable {
        case serviceList, calendar, activity, search, profile
        
        var title: String {
            switch self {
            case .serviceList: "Service List"
            case .calendar: "Calendar"
            case .activity: "Activity"
            case .search: "Search"
            case .profile: "Profile"
            }
        }
        
        var viewController: UIViewController {
            switch self {
            case .serviceList: ServiceListViewController()
            case .calendar: CalendarViewController()
            case .activity: ActivityViewController()
            case .search: SearchViewController()
            case .profile: Routes.userProfileVC ?? UIViewController()
            }
        }
        
        var iconName: String {
            switch self {
            case .serviceList: "house"
            case .calendar: "calendar"
            case .activity: "calendar.circle.fill"
            case .search: "magnifyingglass"
            case .profile: "person.crop.circle"
            }
        }
    }
    
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
        let vcs = Tab.allCases.map { tab -> UIViewController in
            let vc = tab.viewController
            vc.tabBarItem = UITabBarItem(title: tab.title,
                                         image: UIImage(systemName: tab.iconName),
                                         tag: tab.rawValue)
            return vc
        }
        viewControllers = vcs
    }
    
    private func updateNavigation(for index: Int) {
        guard let tab = Tab(rawValue: index),
              let currentVC = viewControllers?[index] else { return }
        
        navigationItem.title = tab.title
        
        switch tab {
        case .profile:
            addSignOutButton()
        default:
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
        updateNavigation(for: item.tag)
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
