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
            createNavController(vc: loadFromStoryboard(.userProfile, "UserProfileViewController"), title: "Profile", image: "person.crop.circle")
        ]
        
        tabBar.tintColor = UIColor(named: "textColor") ?? .black
        tabBar.backgroundColor = .systemBackground
    }
    
    private func loadFromStoryboard(_ storyboard: Storyboard, _ identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }

    
    private func createNavController(vc: UIViewController, title: String, image: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(systemName: image)
        vc.navigationItem.title = title
        return nav
    }
}
