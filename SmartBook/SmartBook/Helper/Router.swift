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
    
    static func showLoginScreenWithTransition() {
        let loginVC = StoryboardInfo.viewController(from: .main, identifier: StoryboardInfo.Identifier.authenticationVC)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()

            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)
        }
    }

}
