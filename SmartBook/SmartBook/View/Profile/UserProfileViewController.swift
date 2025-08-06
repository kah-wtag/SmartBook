//
//  UserProfileViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/8/25.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet var editNameTextField: UITextField!
    @IBOutlet var editNumberTextField: UITextField!
    @IBOutlet var editMailTextField: UITextField!
    @IBOutlet var editDesignationTextField: UITextField!
    @IBOutlet var saveUpdatedProfileButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView!
    
    private var userProfileTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldTargets()
    }
    
    private func setupUI() {
        userProfileTextFields = [editNameTextField, editNumberTextField, editMailTextField, editDesignationTextField]
        let placeholders = ["Md. Kamrul Hasan", "+8801749-140494", "kamrul@gmail.com", "Neurologist"]
        
        for (field, placeholder) in zip(userProfileTextFields, placeholders) {
            field.setStyledPlaceholder(placeholder, color: .textColor)
            field.applyUnderline()
            field.addPadding([.left, .right], width: 8)
            field.font = .textSize(ofSize: .medium)
        }
        
        saveUpdatedProfileButton.isEnabled = false
        saveUpdatedProfileButton.alpha = 1
        saveUpdatedProfileButton.titleLabel?.font = .textSize(ofSize: .large, weight: .semibold)
        saveUpdatedProfileButton.applyButtonRoundBorder(borderColor: .buttonBorderColor, borderWidth: 3, cornerRadius: 10)
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        userProfileImageView.clipsToBounds = true
        
    }
    
    private func setupTextFieldTargets() {
        for textField in userProfileTextFields {
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBAction func editProfileImageTapped(_ sender: Any) {
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let anyFieldHasText = userProfileTextFields.contains {
            !($0.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty
        }
        saveUpdatedProfileButton.isEnabled = anyFieldHasText
        saveUpdatedProfileButton.alpha = anyFieldHasText ? 1.0 : 0.5
    }
    
    @objc func signOutTapped() {
        let loginStoryboard = UIStoryboard(name: StoryboardInfo.Name.main.rawValue, bundle: nil)
        let loginVC = loginStoryboard.instantiateViewController(withIdentifier: StoryboardInfo.Identifier.authenticationVC)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
            
            // Optional: add animation
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)
        }
    }
    
    
}
