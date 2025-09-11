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
    
    private var editMappings: [(stack: UIStackView, textField: UILabel, label: UILabel)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupEditMappings()
        setupGestures()
    }
}

extension UserProfileViewController {
    private func setupUI() {
        [userProfileNameEditTextField, userProfileEditNumberTextField, userProfileEditMailTextField].forEach {
            $0?.horizontalPadding()
            $0?.font = .textSize(ofSize: .regular)
        }
        
        [editProfileNameLabel, editProfileNumberLabel, editProfileMailLabel].forEach {
            $0?.horizontalPadding()
            $0?.font = .textSize(ofSize: .small)
        }
        
        [editProfileNameStackView, editProfileNumberStackView, editProfileMailStackView].forEach {
            $0?.layer.cornerRadius = 10
            $0?.layer.masksToBounds = true
            $0?.backgroundColor = .textfield
        }
        
        editProfileImageButton.setFontSize(.small, weight: .bold)
        userProfileImageView.makeCircular()
        editBackgroundView.alpha = 0.7
        
        setupTextColors()
    }
    
    private func setupTextColors() {
        userProfileNameEditTextField.textColor = .primaryText
        userProfileEditNumberTextField.textColor = .primaryText
        userProfileEditMailTextField.textColor = .primaryText
        editProfileNameLabel.textColor = .primaryText
        editProfileNumberLabel.textColor = .primaryText
        editProfileMailLabel.textColor = .primaryText
        editProfileImageButton.titleLabel?.textColor = .secondaryText
        editBackgroundView.backgroundColor = .background
    }
    
    private func setupEditMappings() {
        editMappings = [
            (editNameStackView, userProfileNameEditTextField, editProfileNameLabel),
            (editNumberStackView, userProfileEditNumberTextField, editProfileNumberLabel),
            (editMailStackView, userProfileEditMailTextField, editProfileMailLabel)
        ]
    }
    
    private func setupGestures() {
        editMappings.forEach { mapping in
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleEditTap(_:)))
            mapping.stack.addGestureRecognizer(tap)
            mapping.stack.isUserInteractionEnabled = true
        }
    }
}

extension UserProfileViewController {
    @objc private func handleEditTap(_ sender: UITapGestureRecognizer) {
        guard let stack = sender.view as? UIStackView,
              let mapping = editMappings.first(where: { $0.stack == stack }) else { return }
        
        openEditProfileVC(text: mapping.textField.text, labelTitle: mapping.label.text)
    }
    
    @IBAction func editProfileImageButtonTapped(_ sender: Any) {
        openImagePicker()
    }
    
    @objc private func notificationTapped() {
        print("Notification tapped")
    }
    
    @objc private func signOutTapped() {
        guard let nav = navigationController else { return }
        Routes.showLoginScreen(in: nav)
    }
}

extension UserProfileViewController {
    private func openEditProfileVC(text: String?, labelTitle: String?) {
        guard let editVC = Routes.userProfileEditVC else { return }
        editVC.initialText = text
        editVC.fieldTitle = labelTitle
        
        editVC.onSave = { [weak self] updatedText in
            guard let self = self else { return }
            self.editMappings.forEach { mapping in
                if mapping.label.text == labelTitle {
                    mapping.textField.text = updatedText
                }
            }
        }
        
        editVC.modalPresentationStyle = .pageSheet
        editVC.modalTransitionStyle = .coverVertical
        present(editVC, animated: true)
    }
}

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openImagePicker() {
        let alert = UIAlertController(title: "Select Image", message: "Choose a source", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                self?.presentPicker(sourceType: .camera)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            self?.presentPicker(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = editProfileImageButton
            popover.sourceRect = editProfileImageButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    private func presentPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            userProfileImageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
