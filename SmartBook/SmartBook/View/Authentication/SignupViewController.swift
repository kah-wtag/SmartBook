//
//  SignupViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

protocol SignupDelegate: AnyObject {
    func signupButtonTapped()
}

import UIKit

class SignupViewController: UIViewController {
    weak var delegate: SignupDelegate?
    
    @IBOutlet var emailSignupTextField: UITextField!
    @IBOutlet var passwordSignupTextField: UITextField!
    @IBOutlet var confirmPasswordSignupTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        signupButton.setFontSize(.regular, weight: .bold)
        emailSignupTextField.setStyledPlaceholder("Email")
        emailSignupTextField.applyUnderline(rightPadding: 10)
        passwordSignupTextField.setStyledPlaceholder("Password")
        passwordSignupTextField.applyUnderline(rightPadding: 10)
        confirmPasswordSignupTextField.setStyledPlaceholder("Confirm Password")
        confirmPasswordSignupTextField.applyUnderline(rightPadding: 10)
        signupButton.applyButtonRoundBorder(borderColor: .textfield, borderWidth: 3, cornerRadius: 10)
        
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        delegate?.signupButtonTapped()
    }
}
