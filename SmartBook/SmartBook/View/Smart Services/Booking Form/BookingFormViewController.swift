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
    @IBOutlet var userAppointmentDateTimePicker: UIDatePicker!
    @IBOutlet var appointmentSubmitButton: UIButton!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var gendarLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var bookingServiceProviderLabel: UILabel!
    @IBOutlet var maleRadioButton: RadioButton!
    @IBOutlet var femaleRadioButton: RadioButton!
    
    let viewModel = BookingFormViewModel()
    private var bookingFormTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book Appointment"
        
        configureViewModel()
        setupUI()
        setupTargets()
        configureTextFields()
        setupServiceProviderName()
        setupGenderRadioButtons()
    }
    
    private func setupGenderRadioButtons() {
        [maleRadioButton, femaleRadioButton].forEach { button in
            button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func genderButtonTapped(_ sender: RadioButton) {
        [maleRadioButton, femaleRadioButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        
        let selectedGender = sender == maleRadioButton ? "Male" : "Female"
        viewModel.updateGender(selectedGender)
        viewModel.validateForm()
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
        userBookingFormBirthDatePicker.maximumDate = Date()
        userAppointmentDateTimePicker.minimumDate = Date()
        setupTextFields()
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
    
    private func setupSubmitButton() {
        appointmentSubmitButton.applyRoundBorder(color: .placeholder)
        appointmentSubmitButton.isEnabled = false
        appointmentSubmitButton.alpha = 0.5
    }
    
    private func setupFontSize() {
        maleRadioButton.setFontSize(.large, weight: .regular, dynamic: true)
        femaleRadioButton.setFontSize(.large, weight: .regular, dynamic: true)
        bookingServiceProviderLabel.setFontSize(.large, weight: .regular, dynamic: true)
        appointmentSubmitButton.setFontSize(.large, weight: .medium, dynamic: true)
        userBookingFormNameTextField.setFontSize(.large, weight: .regular, dynamic: true)
        userBookingFormMailTextField.setFontSize(.large, weight: .regular, dynamic: true)
        userBookingFormPhoneNumberTextField.setFontSize(.large, weight: .regular, dynamic: true)
        dateOfBirthLabel.setFontSize(.large, weight: .regular, dynamic: true)
        gendarLabel.setFontSize(.large, weight: .regular, dynamic: true)
        dateTimeLabel.setFontSize(.large, weight: .regular, dynamic: true)
    }
    
    private func setupTextColor() {
        bookingServiceProviderLabel.textColor = .primaryText
        userBookingFormNameTextField.textColor = .primaryText
        userBookingFormPhoneNumberTextField.textColor = .primaryText
        userBookingFormMailTextField.textColor = .primaryText
        appointmentSubmitButton.titleLabel?.textColor = .secondaryText
        dateOfBirthLabel.textColor = .primaryText
        gendarLabel.textColor = .primaryText
        dateTimeLabel.textColor = .primaryText
    }
    
    private func setupServiceProviderName() {
        bookingServiceProviderLabel.text = viewModel.screenTitle
    }
    
    private func setupTargets() {
        userBookingFormBirthDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        userAppointmentDateTimePicker.addTarget(self, action: #selector(appointmentDateChanged(_:)), for: .valueChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return true }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case userBookingFormNameTextField:
            viewModel.updateName(updatedText)
        case userBookingFormPhoneNumberTextField:
            viewModel.updatePhone(updatedText)
        case userBookingFormMailTextField:
            viewModel.updateEmail(updatedText)
        default:
            break
        }
        viewModel.validateForm()
        return true
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
    
    func didSubmitAppointment() {
        let bookedFormVC = Routes.bookedFormVC
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(bookedFormVC, animated: true)
    }
}
