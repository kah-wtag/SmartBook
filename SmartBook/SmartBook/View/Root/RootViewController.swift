//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 10/8/25.
//

import UIKit

final class RootViewController: UIViewController {

    private let navigationBar = UINavigationBar()
    private let tabBar = UITabBar()
    private let contentContainerView = UIView()
    
    private enum TabInfo {
        static let items: [(title: String, icon: UIImage?)] = [
            ("Home", UIImage(systemName: "house")),
            ("Calendar", UIImage(systemName: "calendar")),
            ("Search", UIImage(systemName: "magnifyingglass")),
            ("Favorites", UIImage(systemName: "heart")),
            ("Profile", UIImage(systemName: "person.crop.circle"))
        ]
    }
    
    private lazy var customChildViewControllers: [UIViewController] = {
        let profileVC = StoryboardInfo.viewController(
            from: .userProfile,
            identifier: StoryboardInfo.Identifier.userProfileVC
        )
        return [
            HomeViewController(),
            CalendarViewController(),
            SearchViewController(),
            FavouriteViewController(),
            profileVC
        ]
    }()
    
    private var activeChildViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTabBar()
        setupContentContainer()
        tabBar.selectedItem = tabBar.items?.first
        selectTab(at: 0)
    }
    
    private func setupNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.tintColor = UIColor(named: "secondaryTextColor")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
    private func setupTabBar() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        tabBar.items = TabInfo.items.enumerated().map { index, tab in
            UITabBarItem(title: tab.title, image: tab.icon, tag: index)
        }
        tabBar.tintColor = UIColor(named: "secondaryTextColor")

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        view.addSubview(tabBar)

        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    private func setupContentContainer() {
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }

    
    private func selectTab(at index: Int) {
        if let activeVC = activeChildViewController {
            activeVC.willMove(toParent: nil)
            activeVC.view.removeFromSuperview()
            activeVC.removeFromParent()
        }
        
        let vc = customChildViewControllers[index]
        addChild(vc)
        vc.view.frame = contentContainerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentContainerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        activeChildViewController = vc
        
        let tabTitle = TabInfo.items[index].title
        let showSignOut = (tabTitle == "Profile")
        updateNavigationBar(title: tabTitle, showSignOut: showSignOut)
    }
    
    private func updateNavigationBar(title: String, showSignOut: Bool) {
        let navItem = UINavigationItem(title: title)
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: self,
            action: #selector(notificationTapped)
        )
        if showSignOut {
            let signOutButton = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.square"),
                style: .plain,
                target: self,
                action: #selector(signOutTapped)
            )
            navItem.rightBarButtonItems = [notificationButton, signOutButton]
        } else {
            navItem.rightBarButtonItem = notificationButton
        }
        navItem.leftBarButtonItem = nil
        navigationBar.setItems([navItem], animated: false)
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        Router.showLoginScreenWithTransition()
    }
}

extension RootViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectTab(at: item.tag)
    }
}
