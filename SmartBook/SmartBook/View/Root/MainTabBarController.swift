//
//  MainTabBarController.swift
//  WelldevTraining SmartBookMainTabbar
//
//  Created by Md. Kamrul Hasan on 21/8/25.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor(named: "secondaryTextColor")
    }

    private func setupViewControllers() {
        let homeVC = HomeViewController()
        homeVC.title = "Service List"
        let calendarVC = CalendarViewController()
        calendarVC.title = "Calendar"
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        let favouritesVC = FavouriteViewController()
        favouritesVC.title = "Favourites"
        
        let profileVC = StoryboardInfo.instantiateVC(
            from: .userProfile,
            identifier: StoryboardInfo.Identifier.userProfileVC
        )
        profileVC.title = "User Profile"
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        calendarVC.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        favouritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 3)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)

        viewControllers = [homeVC, calendarVC, searchVC, favouritesVC, profileVC]
    }
}
