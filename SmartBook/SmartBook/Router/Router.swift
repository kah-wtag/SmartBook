//
//  Router.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case authentication = "Authentication"
    case userProfile = "User Profile"
}

class Router {

    static func show(
        from currentVC: UIViewController,
        storyboard: Storyboard,
        identifier: String,
        title: String? = nil,
        embedInNavigation: Bool = true,
        presentModally: Bool = false
    ) {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: identifier) as? UIViewController else {
            print("Could not instantiate \(identifier) from \(storyboard.rawValue)")
            return
        }

        configureNavigation(for: vc, title: title)

        if embedInNavigation {
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen

            if presentModally {
                currentVC.present(nav, animated: true)
            } else {
                currentVC.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if presentModally {
                currentVC.present(vc, animated: true)
            } else {
                currentVC.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    private static func configureNavigation(for vc: UIViewController, title: String?) {
        vc.title = title
        let textColor = UIColor(named: "textColor") ?? .black
        
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "sign-out"),
            style: .plain,
            target: nil,
            action: nil
        )
        profileButton.tintColor = textColor
        
        let bellButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: nil,
            action: nil
        )
        bellButton.tintColor = textColor
        vc.navigationItem.rightBarButtonItems = [profileButton, bellButton]

        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: nil,
            action: nil
        )
        backButton.tintColor = textColor
        vc.navigationItem.leftBarButtonItem = backButton
    }
}
