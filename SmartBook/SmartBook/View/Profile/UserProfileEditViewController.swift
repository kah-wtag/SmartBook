//
//  UserProfileEditViewController.swift
//  WelldevTraining CalendarSchedule
//
//  Created by Md. Kamrul Hasan on 27/8/25.
//

import UIKit

class UserProfileEditViewController: UIViewController, UITextFieldDelegate {
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
    
    private var characterLimit: Int {
        return isEmailField ? 50 : 25
    }
    
    private var isEmailField: Bool {
        return fieldTitle?.lowercased().contains("email") == true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userProfileEditTextField.delegate = self
        updateCharacterCount()
    }
    
    private func setupUI() {
        userProfileEditDescriptionLable.font = .textSize(ofSize: .small, weight: .light)
        userProfileEditTextField.text = initialText
        userProfileEditTextFieldTitle.text = fieldTitle
        
        userProfileEditTextField.font = .textSize(ofSize: .regular)
        userProfileEditSaveButton.titleLabel?.font = .textSize(ofSize: .regular)
        userProfileEditCancelButton.titleLabel?.font = .textSize(ofSize: .regular)
        userProfileEditTextFieldTitle.font = .textSize(ofSize: .regular)
        textFieldCharacterCount.font = .textSize(ofSize: .regular)
        
        textFieldCharacterLimitWarning.isHidden = true
        userProfileEditSaveButton.isEnabled = false
        textFieldCharacterCount.isHidden = isEmailField
    }
    
    
    @IBAction func userProfileEditSaveButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        
        guard let text = userProfileEditTextField.text else { return }
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        let remaining = characterLimit - trimmed.count
        
        guard !trimmed.isEmpty else { return }
        guard remaining >= 0 else { return }
        if fieldTitle?.lowercased().contains("email") == true {
            guard isValidEmail(trimmed) else { return }
        }
        
        onSave?(trimmed)
        dismiss(animated: true)
    }
    
    @IBAction func userProfileEditCancelButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldCharacterLimitWarning.isHidden = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        updateCharacterCount(for: newText.count)
        validateInput(newText)
        
        return true
    }
    
    private func validateInput(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        let currentCount = trimmed.count
        let remaining = characterLimit - currentCount
        
        var isValid = true
        
        if trimmed.isEmpty {
            isValid = false
        }
        
        if remaining < 0 {
            isValid = false
        }
        
        if fieldTitle?.lowercased().contains("email") == true {
            if !isValidEmail(trimmed) {
                isValid = false
            }
        }
        
        if trimmed.isEmpty {
            userProfileEditSaveButton.isEnabled = false
            textFieldCharacterLimitWarning.isHidden = true
            textFieldCharacterCount.textColor = .label
        } else {
            userProfileEditSaveButton.isEnabled = isValid
            textFieldCharacterLimitWarning.isHidden = false
            if isValid {
                textFieldCharacterLimitWarning.image = UIImage(systemName: "checkmark.circle.fill")
                textFieldCharacterLimitWarning.tintColor = .systemMint
                textFieldCharacterCount.textColor = .systemMint
            } else {
                textFieldCharacterLimitWarning.image = UIImage(systemName: "exclamationmark.triangle.fill")
                textFieldCharacterLimitWarning.tintColor = .systemRed
                textFieldCharacterCount.textColor = .systemRed
            }
        }
    }
    
    private func updateCharacterCount(for count: Int? = nil) {
        guard !isEmailField else { return }
        let currentCount = count ?? userProfileEditTextField.text?.count ?? 0
        let remaining = characterLimit - currentCount
        textFieldCharacterCount.text = "\(remaining)"
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        guard !email.contains(" ") else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,4}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
