//
//  LoginViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailLoginTextField: UITextField!
    @IBOutlet var passwordLoginTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailLoginTextField.setStyledPlaceholder("Email")
        emailLoginTextField.applyUnderline()
        emailLoginTextField.addPadding([.left, .right], width: 8)
        passwordLoginTextField.setStyledPlaceholder("Password")
        passwordLoginTextField.applyUnderline()
        passwordLoginTextField.addPadding([.left, .right], width: 8)
        loginButton.applyButtonRoundBorder(borderColor: .buttonBorderColor, borderWidth: 3, cornerRadius: 10)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //        Router.show(
        //            from: self,
        //            storyboard: .userProfile,
        //            identifier: "UserProfileViewController",
        //            title: "User Profile",
        //            embedInNavigation: true,
        //            presentModally: true
        //        )
        
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
}

