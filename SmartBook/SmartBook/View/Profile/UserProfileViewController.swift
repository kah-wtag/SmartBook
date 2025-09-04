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
    
    @IBOutlet var editMailStackView: UIStackView!
    @IBOutlet var editNumberStackView: UIStackView!
    @IBOutlet var editNameStackView: UIStackView!
    @IBOutlet var userProfileNameEditTextField: UILabel!
    @IBOutlet var userProfileEditNumberTextField: UILabel!
    @IBOutlet var userProfileEditMailTextField: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var editProfileImageButton: UIButton!
    @IBOutlet var editProfileNameLabel: UILabel!
    @IBOutlet var userProfileNumberLabel: UILabel!
    @IBOutlet var userProfileMailLabel: UILabel!
    @IBOutlet var editProfileNameStackView: UIStackView!
    @IBOutlet var editProfileNumberStackView: UIStackView!
    @IBOutlet var editProfileMailStackView: UIStackView!
    @IBOutlet var editbackView: UIView!
    
    enum FieldType {
        case name, number, email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        userProfileNameEditTextField.font = .textSize(ofSize: .regular)
        userProfileEditNumberTextField.font = .textSize(ofSize: .regular)
        userProfileEditMailTextField.font = .textSize(ofSize: .regular)
        
        editProfileImageButton.titleLabel?.font = .textSize(ofSize: .regular)
        editProfileNameLabel.font = .textSize(ofSize: .small)
        userProfileNumberLabel.font = .textSize(ofSize: .small)
        userProfileMailLabel.font = .textSize(ofSize: .small)
        
        let cornerRadius: CGFloat = 10
        let stackViews = [editProfileNameStackView, editProfileNumberStackView, editProfileMailStackView]
        stackViews.forEach { stackView in
            stackView?.layer.cornerRadius = cornerRadius
            stackView?.layer.masksToBounds = true
            stackView?.backgroundColor = .textfield
        }
        
        userProfileImageView.makeCircular()
        editProfileImageButton.applyButtonRoundBorder(
            borderColor: .textfield,
            borderWidth: 0,
            cornerRadius: editProfileImageButton.frame.height / 2
        )
        editProfileImageButton.alpha = 0.7
        editbackView.alpha = 0.7
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(editNameTapped))
        editNameStackView.addGestureRecognizer(nameTap)
        
        let numberTap = UITapGestureRecognizer(target: self, action: #selector(editNumberTapped))
        editNumberStackView.addGestureRecognizer(numberTap)
        
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(editMailTapped))
        editMailStackView.addGestureRecognizer(mailTap)
    }
    
    @objc private func editNameTapped() {
        openEditProfileVC(with: userProfileNameEditTextField.text, fieldType: .name)
    }
    
    @objc private func editNumberTapped() {
        openEditProfileVC(with: userProfileEditNumberTextField.text, fieldType: .number)
    }
    
    @objc private func editMailTapped() {
        openEditProfileVC(with: userProfileEditMailTextField.text, fieldType: .email)
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        Routes.showLoginScreenWithTransition()
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
    
    private func openEditProfileVC(with text: String?, fieldType: FieldType) {
        guard let editVC = StoryboardInfo.instantiateVC(
            from: .userProfileEdit,
            identifier: StoryboardInfo.Identifier.userProfileEditVC
        ) as? UserProfileEditViewController else { return }
        
        editVC.initialText = text
        
        switch fieldType {
        case .name:
            editVC.fieldTitle = editProfileNameLabel.text
        case .number:
            editVC.fieldTitle = userProfileNumberLabel.text
        case .email:
            editVC.fieldTitle = userProfileMailLabel.text
        }
        
        editVC.onSave = { [weak self] updatedText in
            guard let self = self else { return }
            switch fieldType {
            case .name:
                self.userProfileNameEditTextField.text = updatedText
            case .number:
                self.userProfileEditNumberTextField.text = updatedText
            case .email:
                self.userProfileEditMailTextField.text = updatedText
            }
        }
        
        editVC.modalPresentationStyle = .pageSheet
        editVC.modalTransitionStyle = .coverVertical
        present(editVC, animated: true)
    }
}
