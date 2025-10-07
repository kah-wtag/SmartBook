//
//  BookingFormViewController.swift
//  WelldevTraining BookingForm
//
//  Created by Md. Kamrul Hasan on 20/8/25.
//

import UIKit

class BookingFormViewController: UIViewController {
    
    @IBOutlet var userBookingFormNameTextField: UITextField!
    @IBOutlet var userBookingFormPhoneNumberTextField: UITextField!
    @IBOutlet var userBookingFormMailTextField: UITextField!
    @IBOutlet var userBookingFormBirthDatePicker: UIDatePicker!
    @IBOutlet var userBookingFormChoicedGenderLabel: UILabel!
    @IBOutlet var userAppointmentDateTimePicker: UIDatePicker!
    @IBOutlet var appointmentSubmitButton: UIButton!
    @IBOutlet var userBookingFormGenderChoiceButton: UIButton!
    @IBOutlet var dateOfBirthField: UITextField!
    @IBOutlet var gendarField: UITextField!
    @IBOutlet var dateTimeField: UITextField!
    
    private let viewModel = BookingFormViewModel()
    private var bookingFormTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        setupTargets()
    }
    
    private func setupUI() {
        appointmentSubmitButton.setFontSize(.regular, weight: .bold, dynamic: true)
        bookingFormTextFields = [userBookingFormNameTextField,
                                 userBookingFormPhoneNumberTextField,
                                 userBookingFormMailTextField]
        
        let placeholders = ["Full Name", "Phone Number", "Email Address"]
        
        for (field, placeholder) in zip(bookingFormTextFields, placeholders) {
            field.setStyledPlaceholder(placeholder)
            field.textFieldStyle()
        }
        
        userBookingFormBirthDatePicker.datePickerMode = .date
        userBookingFormBirthDatePicker.maximumDate = Date()
        
        userAppointmentDateTimePicker.datePickerMode = .dateAndTime
        userAppointmentDateTimePicker.minimumDate = Date()
        
        userBookingFormChoicedGenderLabel.text = "Not Selected"
        
        appointmentSubmitButton.isEnabled = false
        appointmentSubmitButton.alpha = 0.5
        userBookingFormNameTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormMailTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormPhoneNumberTextField.setFontSize(.regular, weight: .regular, dynamic: true)
        userBookingFormChoicedGenderLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        dateOfBirthField.setFontSize(.regular, weight: .regular, dynamic: true)
        gendarField.setFontSize(.regular, weight: .regular, dynamic: true)
        dateTimeField.setFontSize(.regular, weight: .regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        userBookingFormNameTextField.textColor = .primaryText
        userBookingFormPhoneNumberTextField.textColor = .primaryText
        userBookingFormMailTextField.textColor = .primaryText
        userBookingFormChoicedGenderLabel.textColor = .primaryText
        appointmentSubmitButton.titleLabel?.textColor = .secondaryText
        userBookingFormGenderChoiceButton.titleLabel?.textColor = .secondaryText
        dateOfBirthField.textColor = .primaryText
        gendarField.textColor = .primaryText
        dateTimeField.textColor = .primaryText
    }
    
    private func setupTargets() {
        userBookingFormNameTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        userBookingFormPhoneNumberTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        userBookingFormMailTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
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
