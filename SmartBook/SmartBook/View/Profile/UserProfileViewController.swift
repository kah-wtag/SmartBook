//
//  UserProfileViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/8/25.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet var editNameTextField: UITextField!
    @IBOutlet var editNumberTextField: UITextField!
    @IBOutlet var editMailTextField: UITextField!
    @IBOutlet var editDesignationTextField: UITextField!
    @IBOutlet var saveUpdatedProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let userProfileTextFields = [editNameTextField, editNumberTextField, editMailTextField, editDesignationTextField]
        let userProfileplaceholders = ["Md. Kamrul Hasan", "+8801749-140494", "kamrul@gmail.com", "Neurologist"]
        for (field, placeholder) in zip(userProfileTextFields, userProfileplaceholders) {
            field?.setStyledPlaceholder(placeholder)
            field?.applyUnderline()
            field?.addPadding([.left, .right], width: 8)
        }
        
        saveUpdatedProfileButton.applyButtonRoundBorder(borderColor: .darkGray, borderWidth: 3, cornerRadius: 10)
    }
    
}
