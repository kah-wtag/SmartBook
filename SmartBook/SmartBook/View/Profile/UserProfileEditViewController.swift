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
    @IBOutlet var userProfileEditTextFieldTitle: UILabel!
    @IBOutlet var textFieldCharacterCount: UILabel!
    @IBOutlet var textFieldCharacterLimitWarning: UIImageView!
    
    var initialText: String?
    var fieldTitle: String?
    var onSave: ((String) -> Void)?
    private let characterLimit = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userProfileEditTextField.delegate = self
        updateCharacterCount()
    }
    
    private func setupUI() {
        userProfileEditTextField.text = initialText
        userProfileEditTextFieldTitle.text = fieldTitle
    }
    
    @IBAction func userProfileEditSaveButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        
        guard let text = userProfileEditTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Empty Field", message: "This field cannot be empty.")
            return
        }
        
        let currentCount = text.count
        let remaining = characterLimit - currentCount
        
        guard remaining >= 0 else {
            showAlert(title: "Limit Exceeded", message: "Please reduce your text within \(characterLimit) characters.")
            return
        }
        
        if fieldTitle?.lowercased().contains("mail") == true {
            if !isValidEmail(text) {
                showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
                return
            }
        }
        
        onSave?(text)
        dismiss(animated: true)
    }
    
    @IBAction func userProfileEditCancelButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        updateCharacterCount(for: newText.count)
        
        return true
    }
    
    private func updateCharacterCount(for count: Int? = nil) {
        let currentCount = count ?? userProfileEditTextField.text?.count ?? 0
        let remaining = characterLimit - currentCount
        
        textFieldCharacterCount.text = "\(remaining)"
        
        if remaining >= 0 {
            textFieldCharacterLimitWarning.isHidden = false
            textFieldCharacterLimitWarning.image = UIImage(systemName: "checkmark.circle.fill")
            textFieldCharacterLimitWarning.tintColor = .systemMint
            textFieldCharacterCount.textColor = .systemMint
        } else {
            textFieldCharacterLimitWarning.isHidden = false
            textFieldCharacterLimitWarning.image = UIImage(systemName: "exclamationmark.triangle.fill")
            textFieldCharacterLimitWarning.tintColor = .systemRed
            textFieldCharacterCount.textColor = .systemRed
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
