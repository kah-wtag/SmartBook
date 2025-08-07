//
//  UserProfileViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/8/25.
//

import UIKit

class UserProfileViewController: UIViewController,
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    
    @IBOutlet var editNameTextField: UITextField!
    @IBOutlet var editNumberTextField: UITextField!
    @IBOutlet var editMailTextField: UITextField!
    @IBOutlet var editDesignationTextField: UITextField!
    @IBOutlet var saveUpdatedProfileButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var editProfileImageButton: UIButton!
    
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
        editProfileImageButton.applyButtonRoundBorder(borderColor: .buttonBorderColor, borderWidth: 3, cornerRadius: 10)
        
    }
    
    private func setupTextFieldTargets() {
        for textField in userProfileTextFields {
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            userProfileImageView.image = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func editProfileImageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let anyFieldHasText = userProfileTextFields.contains {
            !($0.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty
        }
        saveUpdatedProfileButton.isEnabled = anyFieldHasText
        saveUpdatedProfileButton.alpha = anyFieldHasText ? 1.0 : 0.5
    }
    
    @objc func signOutTapped() {
        Router.showLoginScreenWithTransition()
    }
}
