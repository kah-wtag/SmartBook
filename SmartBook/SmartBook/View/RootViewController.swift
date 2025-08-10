//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 10/8/25.
//

import UIKit

final class RootViewController: UIViewController, UITabBarDelegate {

    private let navBar = UINavigationBar()
    private let contentView = UIView()
    private let tabBar = UITabBar()

    private let blankRootView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGroupedBackground
        return v
    }()

    private lazy var tabItems: [UITabBarItem] = [
        UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0),
        UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1),
        UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2),
        UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart"), tag: 3),
        UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
    ]

    private lazy var childNavControllers: [UINavigationController] = {
        let home = UINavigationController(rootViewController: HomeViewController())
        let calendar = UINavigationController(rootViewController: CalendarViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let favourite = UINavigationController(rootViewController: FavouriteViewController())
        let profileVC = StoryboardInfo.viewController(from: .userProfile, identifier: StoryboardInfo.Identifier.userProfileVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        return [home, calendar, search, favourite, profileNav]
    }()

    private var currentChildNav: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureTabBar()
        showBlankRootScreen()
    }

    private func setupLayout() {
        navBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground

        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        blankRootView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blankRootView)

        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),

            blankRootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blankRootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blankRootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blankRootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 49)
        ])
    }

    private func configureTabBar() {
        tabBar.items = tabItems
        tabBar.delegate = self
        tabBar.tintColor = UIColor(named: "secondaryTextColor") ?? .systemBlue

        tabBar.selectedItem = nil

        updateNavBar(title: "ROOT VC")
    }

    private func updateNavBar(title: String, rightItems: [UIBarButtonItem]? = nil) {
        let navItem = UINavigationItem(title: title)
        navItem.rightBarButtonItems = rightItems
        navItem.largeTitleDisplayMode = .never
        navBar.prefersLargeTitles = false
        navBar.setItems([navItem], animated: false)
    }

    private func showBlankRootScreen() {
        removeCurrentChild()
        blankRootView.isHidden = false
        blankRootView.backgroundColor = .yellow
        updateNavBar(title: "ROOT View Controller")
        tabBar.selectedItem = nil
    }

    private func removeCurrentChild() {
        if let current = currentChildNav {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
            currentChildNav = nil
        }
    }

    private func displayChildNavController(at index: Int) {
        guard index >= 0 && index < childNavControllers.count else { return }

        let selectedNav = childNavControllers[index]
        if selectedNav == currentChildNav { return }

        blankRootView.isHidden = true
        removeCurrentChild()

        addChild(selectedNav)
        selectedNav.view.frame = contentView.bounds
        selectedNav.view.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(selectedNav.view)
        selectedNav.didMove(toParent: self)
        currentChildNav = selectedNav

        if let top = selectedNav.topViewController {
            let title = top.title ?? tabItems[index].title ?? ""
            let rightItems = top.navigationItem.rightBarButtonItems
            updateNavBar(title: title, rightItems: rightItems)
        }

    }
}

extension RootViewController {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        displayChildNavController(at: index)
    }
}
