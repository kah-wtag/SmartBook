//
//  BookingFormViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 20/8/25.
//

import UIKit

final class BookingFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userBookingFormNameTextField: UITextField!
    @IBOutlet var userBookingFormPhoneNumberTextField: UITextField!
    @IBOutlet var userBookingFormMailTextField: UITextField!
    @IBOutlet var userBookingFormBirthDatePicker: UIDatePicker!
    @IBOutlet var userBookingFormChoicedGenderLabel: UILabel!
    @IBOutlet var userAppointmentDateTimePicker: UIDatePicker!
    @IBOutlet var appointmentSubmitButton: UIButton!
    @IBOutlet var userBookingFormGenderChoiceButton: UIButton!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var gendarLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    
    let viewModel = BookingFormViewModel()
    private var bookingFormTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        configureViewModel()
        setupUI()
        setupTargets()
        configureTextFields()
    }
    
    private func configureTextFields() {
        userBookingFormNameTextField.delegate = self
        userBookingFormPhoneNumberTextField.delegate = self
        userBookingFormMailTextField.delegate = self
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        setupTextFields()
        setupDatePickers()
        setupGenderLabel()
        setupSubmitButton()
        setupFontSize()
        setupTextColor()
    }
    
    private func setupTextFields() {
        bookingFormTextFields = [userBookingFormNameTextField,
                                 userBookingFormPhoneNumberTextField,
                                 userBookingFormMailTextField]
        let placeholders = ["Full Name", "Phone Number", "Email Address"]
        
        for (field, placeholder) in zip(bookingFormTextFields, placeholders) {
            field.setStyledPlaceholder(
                placeholder,
                size: .regular,
                weight: .regular,
                dynamic: true
            )
            field.textFieldStyle()
        }
    }
    
    
    private func setupDatePickers() {
        userBookingFormBirthDatePicker.datePickerMode = .date
        userBookingFormBirthDatePicker.maximumDate = Date()
        userAppointmentDateTimePicker.datePickerMode = .dateAndTime
        userAppointmentDateTimePicker.minimumDate = Date()
    }
    
    private func setupGenderLabel() {
        userBookingFormChoicedGenderLabel.text = "Not Selected"
    }
    
    private func setupSubmitButton() {
        appointmentSubmitButton.applyRoundBorder(color: .placeholder)
        appointmentSubmitButton.isEnabled = false
        appointmentSubmitButton.alpha = 0.5
    }
    
    private func setupFontSize() {
        appointmentSubmitButton.setFontSize(.large, weight: .medium, dynamic: true)
        userBookingFormNameTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormMailTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormPhoneNumberTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormChoicedGenderLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        dateOfBirthLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        gendarLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        dateTimeLabel.setFontSize(.regular, weight: .regular, dynamic: true)
    }
    
    private func setupTextColor() {
        userBookingFormNameTextField.textColor = .primaryText
        userBookingFormPhoneNumberTextField.textColor = .primaryText
        userBookingFormMailTextField.textColor = .primaryText
        userBookingFormChoicedGenderLabel.textColor = .primaryText
        appointmentSubmitButton.titleLabel?.textColor = .secondaryText
        userBookingFormGenderChoiceButton.titleLabel?.textColor = .secondaryText
        dateOfBirthLabel.textColor = .primaryText
        gendarLabel.textColor = .primaryText
        dateTimeLabel.textColor = .primaryText
    }
    
    private func setupTargets() {
        let textFields: [UITextField] = [
            userBookingFormNameTextField,
            userBookingFormPhoneNumberTextField,
            userBookingFormMailTextField
        ]
        textFields.forEach { $0.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged) }
        
        userBookingFormBirthDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        userAppointmentDateTimePicker.addTarget(self, action: #selector(appointmentDateChanged(_:)), for: .valueChanged)
    }
    
    @objc private func textChanged(_ textField: UITextField) {
        switch textField {
        case userBookingFormNameTextField:
            viewModel.updateName(textField.text)
        case userBookingFormPhoneNumberTextField:
            viewModel.updatePhone(textField.text)
        case userBookingFormMailTextField:
            viewModel.updateEmail(textField.text)
        default:
            break
        }
    }
    
    @objc private func dateChanged(_ picker: UIDatePicker) {
        viewModel.updateDateOfBirth(picker.date)
    }
    
    @objc private func appointmentDateChanged(_ picker: UIDatePicker) {
        viewModel.updateAppointmentDate(picker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func userBookingFormGenderChoiceAction(_ sender: Any) {
        let alert = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .actionSheet)
        ["Male", "Female"].forEach { gender in
            alert.addAction(UIAlertAction(title: gender, style: .default) { _ in
                self.viewModel.updateGender(gender)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func userBookingFormSubmitAction(_ sender: Any) {
        viewModel.submitAppointment()
    }
}

extension BookingFormViewController: BookingFormViewModelDelegate {
    func didUpdateFormValidity(isValid: Bool) {
        appointmentSubmitButton.isEnabled = isValid
        appointmentSubmitButton.alpha = isValid ? 1.0 : 0.5
        appointmentSubmitButton.layer.borderColor = (isValid ? UIColor.border : UIColor.placeholder).cgColor
    }
    
    func didSelectGender(_ gender: String) {
        userBookingFormChoicedGenderLabel.text = gender
    }
    
    func didSubmitAppointment() {
        let bookedFormVC = Routes.bookedFormVC
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(bookedFormVC, animated: true)
    }
}
