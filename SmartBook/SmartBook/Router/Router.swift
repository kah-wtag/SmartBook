//
//  Router.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

class Router {
    
    static let shared = Router()
    
    private init() {}
    enum PresentationStyle {
        case push
        case modal
        case presentOverCurrent
        case presentInNavigation
    }

    
    func navigate(to route: Route,
                  from currentVC: UIViewController,
                  presentationStyle: PresentationStyle = .push,
                  animated: Bool = true) {
        
        let targetVC = route.instantiateViewController()
        
        switch presentationStyle {
        case .push:
            if let navController = currentVC.navigationController {
                navController.pushViewController(targetVC, animated: animated)
            } else {
                currentVC.present(targetVC, animated: animated, completion: nil)
            }
            
        case .modal:
            targetVC.modalPresentationStyle = .fullScreen
            currentVC.present(targetVC, animated: animated, completion: nil)
            
        case .presentOverCurrent:
            targetVC.modalPresentationStyle = .overCurrentContext
            currentVC.present(targetVC, animated: animated, completion: nil)
            
        case .presentInNavigation:
            let navVC = UINavigationController(rootViewController: targetVC)
            navVC.modalPresentationStyle = .fullScreen
            currentVC.present(navVC, animated: animated, completion: nil)
        }
    }
}
