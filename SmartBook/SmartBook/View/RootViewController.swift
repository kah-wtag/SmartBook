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
    private let containerView = UIView()
    
    private enum Layout {
        static let navBarHeight: CGFloat = 44
        static let tabBarHeight: CGFloat = 49
    }
    
    private let tabs = [
        ("Home", UIImage(systemName: "house")),
        ("Calendar", UIImage(systemName: "calendar")),
        ("Search", UIImage(systemName: "magnifyingglass")),
        ("Favourite", UIImage(systemName: "heart")),
        ("Profile", UIImage(systemName: "person.crop.circle"))
    ]
    
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
    
    private var currentChildVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTabBar()
        setupContainerView()
        tabBar.selectedItem = tabBar.items?.first
        selectTab(at: 0)
    }
    
    private func setupNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: Layout.navBarHeight)
        ])
        navigationBar.tintColor = .secondaryTextColor
        updateNavigationBar(title: "Home", showSignOut: false)
    }
    
    private func setupTabBar() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        
        tabBar.items = tabs.enumerated().map { index, tab in
            UITabBarItem(title: tab.0, image: tab.1, tag: index)
        }
        
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: Layout.tabBarHeight)
        ])
        tabBar.tintColor = UIColor(named: "secondaryTextColor") ?? .systemBlue
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }
    
    private func selectTab(at index: Int) {
        if let current = currentChildVC {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        let vc = customChildViewControllers[index]
        addChild(vc)
        vc.view.frame = containerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        currentChildVC = vc
        
        let tabTitle = tabs[index].0
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
