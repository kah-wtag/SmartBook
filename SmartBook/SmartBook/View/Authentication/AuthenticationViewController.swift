//
//  AuthenticationViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet var authenticationTitle: UILabel!
    @IBOutlet var otherSignInOptionLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    private enum SegmentedContainerOption: Int {
        case login = 0
        case signup = 1
    }
    
    private lazy var loginVC: LoginViewController? = Routes.loginVC
    private lazy var signupVC: SignupViewController? = Routes.signupVC
    
    private var currentContainerViewIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        containerViewWillUpdate(.login)
    }
    
    private func setupUI() {
        authenticationTitle.font = .textSize(ofSize: .large, weight: .bold)
        otherSignInOptionLabel.font = .textSize(ofSize: .regular)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.primaryReverseText, .font: UIFont.boldSystemFont(ofSize: 15)]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        loginVC?.delegate = self
        signupVC?.delegate = self
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

extension AuthenticationViewController: LoginDelegate {
    func loginButtonTapped() {
        guard let nav = navigationController else { return }
        Routes.rootViewScreen(in: nav)
    }
}


extension AuthenticationViewController: SignupDelegate {
    func signupButtonTapped() {
        segmentedControl.selectedSegmentIndex = 0
        containerViewWillUpdate(.login)
    }
}
