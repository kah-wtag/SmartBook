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
        let userProfileTextFields = [editNameTextField, editNumberTextField, editMailTextField, editDesignationTextField]
        let userProfileplaceholders = ["Md. Kamrul Hasan", "+8801749-140494", "kamrul@gmail.com", "Neurologist"]
        
        for (field, placeholder) in zip(userProfileTextFields, userProfileplaceholders) {
            field?.setStyledPlaceholder(placeholder, color: .textColor)
            field?.applyUnderline()
            field?.addPadding([.left, .right], width: 8)
            field?.font = .appFont(ofSize: .medium)
        }
        
        saveUpdatedProfileButton.isEnabled = false
        saveUpdatedProfileButton.alpha = 1
        saveUpdatedProfileButton.titleLabel?.font = .appFont(ofSize: .large, weight: .semibold)
        saveUpdatedProfileButton.applyButtonRoundBorder(borderColor: .buttonBorderColor, borderWidth: 3, cornerRadius: 10)
        
        userProfileImageView.makeCircular(withRadius: 120)
    }
    
    
    private func setupTextFieldTargets() {
        userProfileTextFields = [editNameTextField, editNumberTextField, editMailTextField, editDesignationTextField]
        for textField in userProfileTextFields {
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let anyFieldHasText = userProfileTextFields.contains { !($0.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty }
        saveUpdatedProfileButton.isEnabled = anyFieldHasText
        saveUpdatedProfileButton.alpha = anyFieldHasText ? 1.0 : 0.5
    }
    
}
