//
//  LoginSegmentViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class LoginSegmentViewController: UIViewController {
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        emailLoginTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        passwordLoginTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        emailLoginTextField.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        passwordLoginTextField.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        
        self.emailLoginTextField.addPaddingToTextField()
        self.passwordLoginTextField.addPaddingToTextField()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailLoginTextField.text, !email.isEmpty,
              let password = passwordLoginTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        if AuthService.shared.login(email: email, password: password) {
            showAlert(message: "Login successful!")
        } else {
            showAlert(message: "Invalid credentials.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension UIView {
    func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.width - 25, height: width)
        self.layer.addSublayer(border)
    }
}

extension UITextField {
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
