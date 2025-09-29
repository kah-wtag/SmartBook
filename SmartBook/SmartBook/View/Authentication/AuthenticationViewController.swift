//
//  AuthenticationViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    
    @IBOutlet var authenticationTitle: UILabel!
    @IBOutlet var otherSignInOptionLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    private enum SegmentedControlOption: Int {
        case login = 0
        case signup = 1
    }
    
    private lazy var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        activityIndicator.tag = 1
        activityIndicator.color = .secondaryText
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return activityIndicator
    }()
    
    private lazy var loginVC = Routes.loginVC
    private lazy var signupVC = Routes.signupVC
    private var currentContainerViewIndex: Int?
    private let viewModel = AuthenticationViewModel()
    
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
        loginVC.delegate = self
        signupVC.delegate = self
        viewModel.delegate = self
        setupTextColor()
    }
    
    private func setupTextColor() {
        authenticationTitle.textColor = .secondaryText
        otherSignInOptionLabel.textColor = .primaryText
    }
    
    private func containerViewWillUpdate(for selectedSegmentControl: SegmentedControlOption) {
        guard selectedSegmentControl.rawValue != currentContainerViewIndex else { return }
        removeCurrentChildViewController()
        
        let vc: UIViewController
        switch selectedSegmentControl {
        case .login: vc = loginVC
        case .signup: vc = signupVC
        }
        
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

extension AuthenticationViewController {
    private func showLoaderUI() {
        loader.startAnimating()
        loader.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    private func hideLoaderUI() {
        loader.stopAnimating()
        loader.isHidden = true
        view.isUserInteractionEnabled = true
    }
}

extension AuthenticationViewController: LoginViewControllerDelegate {
    func loginButtonTapped(username: String?, password: String?) {
        viewModel.loginButtonDidTap()
    }
}

extension AuthenticationViewController: SignupViewControllerDelegate {
    func signupButtonTapped() {
        segmentedControl.selectedSegmentIndex = SegmentedControlOption.login.rawValue
        segmentedControl.sendActions(for: .valueChanged)
    }
}

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    func showLoader() {
        showLoaderUI()
    }
    
    func hideLoader() {
        hideLoaderUI()
    }
    
    func didFetchServices(_ services: [SmartService]) {
        Routes.displayRootScreen()
    }
}
