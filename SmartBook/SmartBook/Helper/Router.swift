//
//  Route.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Router {
    static func showMainTabBar(from presenter: UIViewController) {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        presenter.present(tabBar, animated: true)
    }
}
