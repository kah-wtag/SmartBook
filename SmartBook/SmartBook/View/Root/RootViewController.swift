//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.

import UIKit

final class RootViewController: UITabBarController {
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    private enum Tab: Int, CaseIterable {
        case smartServices, calendar, activity, search, profile
        
        var title: String {
            switch self {
            case .smartServices: "Services"
            case .calendar: "Calendar"
            case .activity: "Activity"
            case .search: "Search"
            case .profile: "Profile"
            }
        }
        
        var viewController: UIViewController {
            switch self {
            case .smartServices: Routes.smartServicesVC
            case .calendar: CalendarViewController()
            case .activity: Routes.appointmentListVC
            case .search: SearchViewController()
            case .profile: Routes.userProfileVC
            }
        }
        
        var iconName: String {
            switch self {
            case .smartServices: "house"
            case .calendar: "calendar"
            case .activity: "calendar.circle.fill"
            case .search: "magnifyingglass"
            case .profile: "person.crop.circle"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        delegate = self
        updateNavigation(for: selectedIndex)
    }
    
    private func configureTabBar() {
        mainTabBar.tintColor = .secondaryText
            mainTabBar.unselectedItemTintColor = .primaryText
            mainTabBar.backgroundColor = .tabBarBackground
            
            mainTabBar.isTranslucent = false
            mainTabBar.barTintColor = .tabBarBackground
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
              let _ = viewControllers?[index] else { return }
        
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
        Routes.displayLoginScreen()
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigation(for: tabBarController.selectedIndex)
    }
}
