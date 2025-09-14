//
//  UserProfileEditViewController.swift
//  WelldevTraining CalendarSchedule
//
//  Created by Md. Kamrul Hasan on 27/8/25.
//

import UIKit

class UserProfileEditViewController: UIViewController {
    @IBOutlet var userProfileEditTextField: UITextField!
    @IBOutlet var userProfileEditSaveButton: UIButton!
    @IBOutlet var userProfileEditCancelButton: UIButton!
    @IBOutlet var userProfileEditTextFieldTitle: UILabel!
    @IBOutlet var textFieldCharacterCount: UILabel!
    @IBOutlet var textFieldCharacterLimitWarning: UIImageView!
    @IBOutlet var userProfileEditDescriptionLable: UILabel!
    
    var initialText: String?
    var fieldTitle: String?
    var onSave: ((String) -> Void)?
    
    private var characterLimit: Int { isEmailField ? 50 : 25 }
    private var isEmailField: Bool { fieldTitle?.lowercased().contains("email") == true }
    
    private var currentText: String { userProfileEditTextField.text?.trimmingCharacters(in: .whitespaces) ?? "" }
    private var isTextCountVisible: Bool {
        guard let title = fieldTitle?.lowercased() else { return true }
        return !(title.contains("email") || title.contains("phone"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userProfileEditTextField.delegate = self
        updateCharacterCount()
    }
}

extension UserProfileEditViewController {
    private func setupUI() {
        textFieldCharacterCount.isHidden = !isTextCountVisible
        textFieldCharacterCount.setFontSize(.regular, dynamic: false)
        userProfileEditTextField.horizontalPadding()
        userProfileEditTextField.text = initialText
        userProfileEditTextField.setFontSize(.regular, dynamic: true)
        userProfileEditTextFieldTitle.text = fieldTitle
        userProfileEditTextFieldTitle.setFontSize(.large, dynamic: false)
        userProfileEditDescriptionLable.setFontSize(.small, weight: .light, dynamic: true)
        textFieldCharacterLimitWarning.isHidden = true
        userProfileEditSaveButton.setFontSize(.regular, dynamic: true)
        userProfileEditSaveButton.isEnabled = false
        userProfileEditCancelButton.setFontSize(.regular, dynamic: true)
        setupTextColor()
    }

    private func setupTextColor() {
        userProfileEditTextField.textColor = .primaryText
        userProfileEditTextField.backgroundColor = .textfield
        textFieldCharacterCount.textColor = .secondaryText
        textFieldCharacterCount.backgroundColor = .textfield
        userProfileEditDescriptionLable.textColor = .primaryText
        userProfileEditSaveButton.titleLabel?.textColor = .secondaryText
        userProfileEditCancelButton.titleLabel?.textColor = .secondaryText
    }
}

extension UserProfileEditViewController {
    @IBAction func userProfileEditSaveButtonAction(_ sender: Any) {
        saveButtonTapped()
    }
    
    @IBAction func userProfileEditCancelButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    func saveButtonTapped() {
        userProfileEditTextField.resignFirstResponder()
        guard !currentText.isEmpty, currentText.count <= characterLimit else { return }
        if isEmailField, !isValidEmail(currentText) { return }
        
        onSave?(currentText)
        dismiss(animated: true)
    }
}

extension UserProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldCharacterLimitWarning.isHidden = false
        
        if let stackView = textFieldCharacterCount.superview as? UIStackView {
            stackView.removeArrangedSubview(textFieldCharacterCount)
            stackView.insertArrangedSubview(textFieldCharacterCount, at: 0)
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        updateCharacterCount(for: newText.count)
        validateInput(newText)
        return true
    }
}

extension UserProfileEditViewController {
    private func validateInput(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        let remaining = characterLimit - trimmed.count
        var isValid = !trimmed.isEmpty && remaining >= 0
        
        if isEmailField, !isValidEmail(trimmed) {
            isValid = false
        }
        
        userProfileEditSaveButton.isEnabled = isValid
        
        if trimmed.isEmpty {
            textFieldCharacterLimitWarning.isHidden = false
            textFieldCharacterLimitWarning.image = UIImage(systemName: "exclamationmark.triangle.fill")
            textFieldCharacterLimitWarning.tintColor = .warning
            textFieldCharacterCount.textColor = .warning
        } else {
            textFieldCharacterLimitWarning.isHidden = false
            if isValid {
                textFieldCharacterLimitWarning.image = UIImage(systemName: "checkmark.circle.fill")
                textFieldCharacterLimitWarning.tintColor = .reverseWarning
                textFieldCharacterCount.textColor = .reverseWarning
            } else {
                textFieldCharacterLimitWarning.image = UIImage(systemName: "exclamationmark.triangle.fill")
                textFieldCharacterLimitWarning.tintColor = .warning
                textFieldCharacterCount.textColor = .warning
            }
        }
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        guard !email.contains(" ") else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

extension UserProfileEditViewController {
    private func updateCharacterCount(for count: Int? = nil) {
        guard isTextCountVisible else { return }
        let currentCount = count ?? userProfileEditTextField.text?.count ?? 0
        let remaining = characterLimit - currentCount
        textFieldCharacterCount.text = "\(remaining)"
    }
    
}
