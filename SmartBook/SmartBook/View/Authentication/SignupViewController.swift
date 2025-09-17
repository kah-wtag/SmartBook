//
//  SignupViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

protocol SignupViewControllerDelegate: AnyObject {
    func signupButtonTapped()
}

class SignupViewController: UIViewController {
    
    @IBOutlet var emailSignupTextField: UITextField!
    @IBOutlet var passwordSignupTextField: UITextField!
    @IBOutlet var confirmPasswordSignupTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    weak var delegate: SignupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        signupButton.setFontSize(.regular, weight: .bold, dynamic: true)
        signupButton.applyRoundBorder(color: .textfield, width: 3, radius: 10)
        emailSignupTextField.setStyledPlaceholder("Email")
        emailSignupTextField.textFieldStyle(dynamic: true)
        passwordSignupTextField.setStyledPlaceholder("Password")
        passwordSignupTextField.textFieldStyle(dynamic: true)
        confirmPasswordSignupTextField.setStyledPlaceholder("Confirm Password")
        confirmPasswordSignupTextField.textFieldStyle(dynamic: true)
        setupTextColor()
    }

    
    private func setupTextColor() {
        emailSignupTextField.textColor = .primaryText
        emailSignupTextField.backgroundColor = .textfield
        passwordSignupTextField.textColor = .primaryText
        passwordSignupTextField.backgroundColor = .textfield
        confirmPasswordSignupTextField.textColor = .primaryText
        confirmPasswordSignupTextField.backgroundColor = .textfield
        signupButton.titleLabel?.textColor = .secondaryText
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        delegate?.signupButtonTapped()
    }
}
