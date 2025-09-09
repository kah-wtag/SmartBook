//
//  LoginViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

protocol LoginDelegate: AnyObject {
    func loginButtonTapped()
}

import UIKit

class LoginViewController: UIViewController {
    weak var delegate: LoginDelegate?
    
    @IBOutlet var emailLoginTextField: UITextField!
    @IBOutlet var passwordLoginTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loginButton.setFontSize(.regular, weight: .bold)
        forgetPasswordButton.setFontSize(.small)
        emailLoginTextField.setStyledPlaceholder("Email")
        emailLoginTextField.applyUnderline(leftPadding: 10, rightPadding: 10)
        emailLoginTextField.addPadding([.left, .right], width: 8)
        passwordLoginTextField.setStyledPlaceholder("Password")
        passwordLoginTextField.applyUnderline(leftPadding: 10, rightPadding: 10)
        passwordLoginTextField.addPadding([.left, .right], width: 8)
        loginButton.applyButtonRoundBorder(borderColor: .textfield, borderWidth: 3, cornerRadius: 10)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        delegate?.loginButtonTapped()
    }
    
}

