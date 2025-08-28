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
    @IBOutlet var userProfileEditTextFieldTitle: UILabel!
    
    var initialText: String?
    var fieldTitle: String?
    var onSave: ((String) -> Void)?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupToolbar()
        
        userProfileEditTextField.text = initialText
        userProfileEditTextFieldTitle.text = fieldTitle
        }

        private func setupUI() {
            userProfileEditTextField.layer.borderWidth = 2
            userProfileEditTextField.layer.borderColor = UIColor.systemMint.cgColor
            userProfileEditTextField.layer.cornerRadius = 5

            userProfileEditSaveButton.layer.borderWidth = 3
            userProfileEditSaveButton.layer.borderColor = UIColor.systemBlue.cgColor
            userProfileEditSaveButton.layer.cornerRadius = 10
        }
    @IBAction func userProfileEditSaveButtonAction(_ sender: Any) {
        userProfileEditTextField.resignFirstResponder()
            if let text = userProfileEditTextField.text {
                onSave?(text) 
            }
            navigationController?.popViewController(animated: true)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        
        toolbar.items = [cancelButton, resetButton, flexibleSpace, doneButton]
        
        userProfileEditTextField.inputAccessoryView = toolbar
    }

    
    

        @objc private func cancelPressed() {
            userProfileEditTextField.resignFirstResponder()
        }

        @objc private func resetPressed() {
            userProfileEditTextField.text = ""
        }

        @objc private func donePressed() {
            userProfileEditTextField.resignFirstResponder()
        }
    }
