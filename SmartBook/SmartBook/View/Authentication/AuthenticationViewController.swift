//
//  AuthenticationViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    private struct AuthStoryboard {
        static let mainStoryBoardName = "Authentication"
        
        struct Identifier {
            static let loginViewController = "LoginViewController"
            static let signupViewController = "SignupViewController"
        }
    }
    
    private enum SegmentedContainerOption: Int {
        case login = 0
        case signup = 1
    }
    
    private lazy var loginVC: LoginViewController? = {
        UIStoryboard(name: AuthStoryboard.mainStoryBoardName, bundle: nil)
            .instantiateViewController(withIdentifier: AuthStoryboard.Identifier.loginViewController) as? LoginViewController
    }()

    private lazy var signupVC: SignupViewController? = {
        UIStoryboard(name: AuthStoryboard.mainStoryBoardName, bundle: nil)
            .instantiateViewController(withIdentifier: AuthStoryboard.Identifier.signupViewController) as? SignupViewController
    }()
    
    private var currentContainerViewIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContainerView()
        containerViewWillUpdate(.login)
    }
    
    private func setupContainerView() {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
    }
    
    @IBAction func segmentSelectionDidChange(_ sender: UISegmentedControl) {
        guard let selectedSegment = SegmentedContainerOption(rawValue: sender.selectedSegmentIndex) else { return }
        containerViewWillUpdate(selectedSegment)
    }
    
    private func containerViewWillUpdate(_ segment: SegmentedContainerOption) {
        guard segment.rawValue != currentContainerViewIndex else { return }
        
        removeCurrentChildViewController()
        
        let newChildVCForDisplay: UIViewController? = switch segment {
        case .login: loginVC
        case .signup: signupVC
        }
        
        guard let vcToDisplay = newChildVCForDisplay else { return }
        
        addChild(vcToDisplay)
        vcToDisplay.view.frame = containerView.bounds
        containerView.addSubview(vcToDisplay.view)
        vcToDisplay.didMove(toParent: self)
        
        currentContainerViewIndex = segment.rawValue
    }
    
    private func removeCurrentChildViewController() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}
