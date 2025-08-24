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
        setupViewControllers()
        delegate = self
        updateNavigation(for: selectedIndex)
    }

    private func setupViewControllers() {
        tabBar.tintColor = .secondaryTextColor
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let calendarVC = CalendarViewController()
        calendarVC.title = "Calendar"
        let calendarNav = UINavigationController(rootViewController: calendarVC)
        calendarNav.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1)

        let searchVC = SearchViewController()
        searchVC.title = "Search"
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)

        let favouritesVC = FavouriteViewController()
        favouritesVC.title = "Favourites"
        let favouritesNav = UINavigationController(rootViewController: favouritesVC)
        favouritesNav.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 3)

        let profileVC = StoryboardInfo.instantiateVC(
            from: .userProfile,
            identifier: StoryboardInfo.Identifier.userProfileVC
        )
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)

        viewControllers = [homeNav, calendarNav, searchNav, favouritesNav, profileNav]
    }

    private func updateNavigation(for index: Int) {
        guard let navController = viewControllers?[index] as? UINavigationController,
              let currentVC = navController.topViewController else { return }

        if index == 4 {
            currentVC.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.square")?.withTintColor(.secondaryTextColor, renderingMode: .alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(signOutTapped)
            )
        } else {
            currentVC.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "bell")?.withTintColor(.secondaryTextColor, renderingMode: .alwaysOriginal),
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
        Router.showLoginScreenWithTransition()
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigation(for: tabBarController.selectedIndex)
    }
}
