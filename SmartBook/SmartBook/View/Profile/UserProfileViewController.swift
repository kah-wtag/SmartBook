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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let textFields = [editNameTextField, editNumberTextField, editMailTextField, editDesignationTextField]
        let placeholders = ["Name", "Phone Number", "Email", "Designation"]
        for (field, placeholder) in zip(textFields, placeholders) {
            field?.setStyledPlaceholder(placeholder)
            field?.applyUnderline()
            field?.addPadding([.left, .right], width: 8)
        }
    }
    
}
