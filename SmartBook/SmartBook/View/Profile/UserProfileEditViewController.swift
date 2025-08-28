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
    
    var initialText: String?
        var fieldTitle: String?
        var onSave: ((String) -> Void)?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            
            userProfileEditTextField.delegate = self
            textFieldDidBeginEditing(userProfileEditTextField)
        }
        
        private func setupUI() {
            userProfileEditTextField.layer.borderWidth = 2
            userProfileEditTextField.layer.borderColor = UIColor.systemMint.cgColor
            userProfileEditTextField.layer.cornerRadius = 5
            
            userProfileEditSaveButton.layer.borderWidth = 3
            userProfileEditSaveButton.layer.borderColor = UIColor.systemBlue.cgColor
            userProfileEditSaveButton.layer.cornerRadius = 10
            
            userProfileEditTextField.text = initialText
            userProfileEditTextFieldTitle.text = fieldTitle
        }
        
        @IBAction func userProfileEditSaveButtonAction(_ sender: Any) {
            userProfileEditTextField.resignFirstResponder()
            if let text = userProfileEditTextField.text {
                onSave?(text)
            }
            navigationController?.popViewController(animated: true)
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillHide(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
            let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPressed))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
            
            toolbar.items = [cancelButton, resetButton, flexibleSpace, doneButton]
            
            textField.inputAccessoryView = toolbar
            textField.reloadInputViews()
        }
        
        @objc private func keyboardWillHide(_ notification: Notification) {
            cancelPressed()
        }
        
        @objc private func cancelPressed() {
            userProfileEditTextField.endEditing(true)
        }
        
        @objc private func resetPressed() {
            userProfileEditTextField.text = ""
        }
        
        @objc private func donePressed() {
            userProfileEditTextField.resignFirstResponder()
        }
    }
