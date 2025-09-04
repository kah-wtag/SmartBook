//
//  SignupViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet var emailSignupTextField: UITextField!
    @IBOutlet var passwordSignupTextField: UITextField!
    @IBOutlet var confirmPasswordSignupTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        signupButton.titleLabel?.font = .textSize(ofSize: .extraLarge, weight: .medium)
        emailSignupTextField.setStyledPlaceholder("Email")
        emailSignupTextField.applyUnderline()
        passwordSignupTextField.setStyledPlaceholder("Password")
        passwordSignupTextField.applyUnderline()
        confirmPasswordSignupTextField.setStyledPlaceholder("Confirm Password")
        confirmPasswordSignupTextField.applyUnderline()
        signupButton.applyButtonRoundBorder(borderColor: .textfield, borderWidth: 3, cornerRadius: 10)
        
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        Routes.showLoginScreenWithTransition()
    }
}
