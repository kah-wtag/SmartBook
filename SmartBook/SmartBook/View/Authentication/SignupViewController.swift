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
        emailSignupTextField.setStyledPlaceholder("Email")
        emailSignupTextField.addPadding([.left, .right], width: 8)
        emailSignupTextField.applyUnderline()
        passwordSignupTextField.setStyledPlaceholder("Password")
        passwordSignupTextField.addPadding([.left, .right], width: 8)
        passwordSignupTextField.applyUnderline()
        confirmPasswordSignupTextField.setStyledPlaceholder("Confirm Password")
        confirmPasswordSignupTextField.addPadding([.left, .right], width: 8)
        confirmPasswordSignupTextField.applyUnderline()
        signupButton.applyButtonRoundBorder(borderColor: .buttonBorderColor, borderWidth: 3, cornerRadius: 10)
        
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        Router.show(
            from: self,
            storyboard: .userProfile,
            identifier: "UserProfileViewController",
            title: "User Profile",
            embedInNavigation: true,
            presentModally: true
        )
    }
}
