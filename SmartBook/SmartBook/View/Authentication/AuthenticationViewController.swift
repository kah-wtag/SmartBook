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
    
    private enum SegmentedControlOption: Int {
        case login = 0
        case signup = 1
    }
    
    private lazy var loginVC: LoginViewController? = Routes.loginVC
    private lazy var signupVC: SignupViewController? = Routes.signupVC
    
    private var currentContainerViewIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        segmentedControl.selectedSegmentIndex = SegmentedControlOption.login.rawValue
        segmentSelectionDidChange(segmentedControl)
    }
    
    @IBAction func segmentSelectionDidChange(_ sender: UISegmentedControl) {
        guard let selectedSegment = SegmentedControlOption(rawValue: sender.selectedSegmentIndex) else { return }
        containerViewWillUpdate(for: selectedSegment)
    }
}

extension AuthenticationViewController {
    private func setupUI() {
        segmentedControl.setFontSize(.regular, weight: .regular, dynamic: true)
        authenticationTitle.setFontSize(.title, weight: .bold, dynamic: true)
        otherSignInOptionLabel.setFontSize(.regular, dynamic: true)
        loginVC?.delegate = self
        signupVC?.delegate = self
        setupTextColor()
    }
    
    private func setupTextColor() {
        authenticationTitle.textColor = .secondaryText
        otherSignInOptionLabel.textColor = .primaryText
    }
    
    private func containerViewWillUpdate(for selectedSegmentControl: SegmentedControlOption) {
        guard selectedSegmentControl.rawValue != currentContainerViewIndex else { return }
        
        removeCurrentChildViewController()
        
        let childVCToDisplay: UIViewController? = switch selectedSegmentControl {
        case .login: loginVC
        case .signup: signupVC
        }
        
        guard let vc = childVCToDisplay else { return }
        
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        currentContainerViewIndex = selectedSegmentControl.rawValue
    }
    
    private func removeCurrentChildViewController() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}

extension AuthenticationViewController: LoginViewControllerDelegate {
    func loginButtonTapped() {
        Routes.displayRootScreen()
    }
}

extension AuthenticationViewController: SignupViewControllerDelegate {
    func signupButtonTapped() {
        segmentedControl.selectedSegmentIndex = SegmentedControlOption.login.rawValue
        segmentedControl.sendActions(for: .valueChanged)
    }
}
