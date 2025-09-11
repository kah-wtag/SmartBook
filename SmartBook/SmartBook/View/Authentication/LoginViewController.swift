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
        loginButton.setFontSize(.regular, weight: .bold)
        forgetPasswordButton.setFontSize(.small)
        emailLoginTextField.setStyledPlaceholder("Email")
        emailLoginTextField.applyUnderline(leftPadding: 10, rightPadding: 10)
        emailLoginTextField.verticalPadding([.left, .right], width: 8)
        passwordLoginTextField.setStyledPlaceholder("Password")
        passwordLoginTextField.applyUnderline(leftPadding: 10, rightPadding: 10)
        passwordLoginTextField.verticalPadding([.left, .right], width: 8)
        loginButton.applyButtonRoundBorder(borderColor: .textfield, borderWidth: 3, cornerRadius: 10)
        
        setupTextColor()
    }
    
    private func setupTextColor() {
        emailLoginTextField.textColor = .primaryText
        passwordLoginTextField.textColor = .primaryText
        loginButton.titleLabel?.textColor = .secondaryText
        forgetPasswordButton.titleLabel?.textColor = .secondaryText
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        delegate?.loginButtonTapped()
    }
    
}

