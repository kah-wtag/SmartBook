//
//  LoginViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginButtonTapped()
}

class LoginViewController: UIViewController {
    
    @IBOutlet var emailLoginTextField: UITextField!
    @IBOutlet var passwordLoginTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!

    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loginButton.setFontSize(.regular, weight: .bold, dynamic: true)
        loginButton.applyRoundBorder(color: .textfield, width: 3, radius: 10)
        forgetPasswordButton.setFontSize(.small, dynamic: true)
        emailLoginTextField.setStyledPlaceholder("Email")
        emailLoginTextField.textFieldStyle(dynamic: true)
        emailLoginTextField.verticalPadding([.left, .right], width: 8)
        passwordLoginTextField.setStyledPlaceholder("Password")
        passwordLoginTextField.textFieldStyle(dynamic: true)
        passwordLoginTextField.verticalPadding([.left, .right], width: 8)
        setupTextColor()
    }
    
    private func setupTextColor() {
        emailLoginTextField.textColor = .primaryText
        emailLoginTextField.backgroundColor = .textfield
        passwordLoginTextField.textColor = .primaryText
        passwordLoginTextField.backgroundColor = .textfield
        loginButton.titleLabel?.textColor = .secondaryText
        forgetPasswordButton.titleLabel?.textColor = .secondaryText
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        delegate?.loginButtonTapped()
    }
    
}

