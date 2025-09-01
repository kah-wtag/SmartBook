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
        if let text = userProfileEditTextField.text {
            onSave?(text)
        }
        dismiss(animated: true)
    }
    
    @IBAction func userProfileEditCancelButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        if newText.count <= characterLimit {
            updateCharacterCount(for: newText.count)
            return true
        } else {
            return false
        }
    }
    
    private func updateCharacterCount(for count: Int? = nil) {
        let currentCount = count ?? userProfileEditTextField.text?.count ?? 0
        textFieldCharacterCount.text = "\(currentCount)/\(characterLimit)"
    }
}
