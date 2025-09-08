//
//  UserProfileViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/8/25.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet var editMailStackView: UIStackView!
    @IBOutlet var editNumberStackView: UIStackView!
    @IBOutlet var editNameStackView: UIStackView!
    @IBOutlet var userProfileNameEditTextField: UILabel!
    @IBOutlet var userProfileEditNumberTextField: UILabel!
    @IBOutlet var userProfileEditMailTextField: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var editProfileImageButton: UIButton!
    @IBOutlet var editProfileNameLabel: UILabel!
    @IBOutlet var editProfileNumberLabel: UILabel!
    @IBOutlet var editProfileMailLabel: UILabel!
    @IBOutlet var editProfileNameStackView: UIStackView!
    @IBOutlet var editProfileNumberStackView: UIStackView!
    @IBOutlet var editProfileMailStackView: UIStackView!
    @IBOutlet var editBackgroundView: UIView!
    
    enum FieldType {
        case name, number, email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
}

extension UserProfileViewController {
    private func setupUI() {
        let textFields = [userProfileNameEditTextField, userProfileEditNumberTextField, userProfileEditMailTextField]
        textFields.forEach { $0?.setHorizontalPadding(); $0?.font = .textSize(ofSize: .regular) }
        
        let labels = [editProfileNameLabel, editProfileNumberLabel, editProfileMailLabel]
        labels.forEach { $0?.setHorizontalPadding(); $0?.font = .textSize(ofSize: .small) }
        
        editProfileImageButton.setFontSize(.regular, weight: .bold)
        
        let stackViews = [editProfileNameStackView, editProfileNumberStackView, editProfileMailStackView]
        stackViews.forEach { stackView in
            stackView?.layer.cornerRadius = 10
            stackView?.layer.masksToBounds = true
            stackView?.backgroundColor = .textfield
        }
        
        userProfileImageView.makeCircular()
        editBackgroundView.alpha = 0.7
    }
    
    private func setupGestures() {
        addTapGesture(to: editNameStackView, action: #selector(editNameTapped))
        addTapGesture(to: editNumberStackView, action: #selector(editNumberTapped))
        addTapGesture(to: editMailStackView, action: #selector(editMailTapped))
    }
    
    private func addTapGesture(to view: UIView, action: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
    }
}

extension UserProfileViewController {
    @objc private func editNameTapped() { openEditProfileVC(with: userProfileNameEditTextField.text, fieldType: .name) }
    @objc private func editNumberTapped() { openEditProfileVC(with: userProfileEditNumberTextField.text, fieldType: .number) }
    @objc private func editMailTapped() { openEditProfileVC(with: userProfileEditMailTextField.text, fieldType: .email) }
    @IBAction func editProfileImageButtonTapped(_ sender: Any) {
        openImagePicker()
    }
    
    @objc private func notificationTapped() { print("Notification tapped") }
    @objc private func signOutTapped() { Routes.showLoginScreen() }
}

extension UserProfileViewController {
    private func openEditProfileVC(with text: String?, fieldType: FieldType) {
        guard let editVC = Routes.userProfileEditVC else { return }
        editVC.initialText = text
        editVC.fieldTitle = fieldTitle(for: fieldType)
        
        editVC.onSave = { [weak self] updatedText in
            guard let self = self else { return }
            switch fieldType {
            case .name: self.userProfileNameEditTextField.text = updatedText
            case .number: self.userProfileEditNumberTextField.text = updatedText
            case .email: self.userProfileEditMailTextField.text = updatedText
            }
        }
        
        editVC.modalPresentationStyle = .pageSheet
        editVC.modalTransitionStyle = .coverVertical
        present(editVC, animated: true)
    }
    
    private func fieldTitle(for type: FieldType) -> String? {
        switch type {
        case .name: return editProfileNameLabel.text
        case .number: return editProfileNumberLabel.text
        case .email: return editProfileMailLabel.text
        }
    }
}

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func openImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let selectedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        if let image = selectedImage { userProfileImageView.image = image }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { dismiss(animated: true) }
}
