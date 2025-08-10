//
//  RootViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 10/8/25.
//

import UIKit

final class RootViewController: UIViewController, UITabBarDelegate {

    private let contentView = UIView()
    private let tabBar = UITabBar()

    private let blankRootView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.yellow
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
    }

    private func setupLayout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        blankRootView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blankRootView)

        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        contentView.addSubview(selectedNav.view)
        selectedNav.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedNav.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectedNav.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectedNav.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectedNav.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        selectedNav.didMove(toParent: self)
        currentChildNav = selectedNav

    }
}

extension RootViewController {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        displayChildNavController(at: index)
        self.title = tabItems[index].title
    }
}
