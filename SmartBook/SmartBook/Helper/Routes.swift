//
//  Routes.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

struct Routes {

    private static func makeRootViewController() -> RootViewController {
        return RootViewController()
    }

    private static func makeLoginViewController() -> UIViewController {
        return StoryboardInfo.instantiateVC(
            from: .main,
            identifier: StoryboardInfo.Identifier.authenticationVC
        )
    }

    static func presentMainAppFlow() {
        let rootVC = makeRootViewController()
        setRootViewController(rootVC, transition: .transitionFlipFromRight)
    }

    static func showLoginScreen() {
        let loginVC = makeLoginViewController()
        setRootViewController(loginVC, transition: .transitionFlipFromLeft)
    }

    private static func setRootViewController(_ vc: UIViewController, transition: UIView.AnimationOptions) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: transition,
                          animations: nil)
    }
}
