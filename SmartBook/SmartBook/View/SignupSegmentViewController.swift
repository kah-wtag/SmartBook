//
//  SignupSegmentViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class SignupSegmentViewController: UIViewController {
    
    @IBOutlet weak var emailSignupTextField: UITextField!
    @IBOutlet weak var passwordSignupTextField: UITextField!
    @IBOutlet weak var confirmPasswordSignupTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        emailSignupTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        passwordSignupTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        confirmPasswordSignupTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        emailSignupTextField.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        passwordSignupTextField.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        confirmPasswordSignupTextField.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        
        self.emailSignupTextField.addPaddingToTextField()
        self.passwordSignupTextField.addPaddingToTextField()
        self.confirmPasswordSignupTextField.addPaddingToTextField()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let email = emailSignupTextField.text, !email.isEmpty,
              let password = passwordSignupTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordSignupTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill all fields.")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        let user = User(email: email, password: password)
        if AuthService.shared.signup(user: user) {
            showAlert(message: "Signup successful!")
        } else {
            showAlert(message: "Email already exists.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
