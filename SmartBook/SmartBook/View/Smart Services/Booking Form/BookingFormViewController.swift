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
    @IBOutlet var userAppointmentTimePicker: UIDatePicker!
    @IBOutlet var userAppointmentDatePicker: UIDatePicker!
    @IBOutlet var appointmentSubmitButton: UIButton!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var gendarLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var bookingServiceProviderLabel: UILabel!
    @IBOutlet var genderRadioGroup: RadioButtonGroupView!
    @IBOutlet var basicInformationLabel: UILabel!
    @IBOutlet var appointmentMessageLabel: UILabel!
    @IBOutlet var appointmentDatePlaceholderLabel: UILabel!
    @IBOutlet var appointmentTimePlaceholderLabel: UILabel!
    
    let viewModel = BookingFormViewModel()
    private var bookingFormTextFields: [UITextField] = []
    private var selectedAppointmentDate: Date? = nil
    private var selectedAppointmentTime: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Book Appointment"
        configureViewModel()
        setupUI()
        setupTargets()
        configureTextFields()
        setupServiceProviderName()
        configureRadioButton()
        updateMessageAfterPlaceholderTap()
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        setupTextFields()
        setupSubmitButton()
        setupFontSize()
        setupTextColor()
        setupDatePicker()
        setupDatePickerPlaceholders()
    }
    
    private func setupTextFields() {
        userBookingFormNameTextField.setStyledPlaceholder("Full Name", size: .large)
        userBookingFormNameTextField.textFieldStyle(dynamic: true)
        userBookingFormNameTextField .verticalPadding([.left, .right], width: 8)
        userBookingFormMailTextField.setStyledPlaceholder("Email Address", size: .large)
        userBookingFormMailTextField.textFieldStyle(dynamic: true)
        userBookingFormMailTextField .verticalPadding([.left, .right], width: 8)
        userBookingFormPhoneNumberTextField.setStyledPlaceholder("Phone Number", size: .large)
        userBookingFormPhoneNumberTextField.textFieldStyle(dynamic: true)
        userBookingFormPhoneNumberTextField .verticalPadding([.left, .right], width: 8)
    }
    
    private func setupSubmitButton() {
        appointmentSubmitButton.applyRoundBorder(color: .placeholder)
        appointmentSubmitButton.isEnabled = false
        appointmentSubmitButton.alpha = 0.5
    }
    
    private func setupFontSize() {
        appointmentMessageLabel.setFontSize(.small, weight: .regular, dynamic: true)
        basicInformationLabel.setFontSize(.large, weight: .regular, dynamic: true)
        bookingServiceProviderLabel.setFontSize(.large, weight: .regular, dynamic: true)
        appointmentSubmitButton.setFont(.large, weight: .medium, dynamic: true, title: "Submit")
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
        dateOfBirthLabel.textColor = .primaryText
        gendarLabel.textColor = .primaryText
        dateTimeLabel.textColor = .primaryText
    }
    
    private func setupDatePicker() {
        userBookingFormBirthDatePicker.contentHorizontalAlignment = .center
        userAppointmentDatePicker.contentHorizontalAlignment = .center
        userAppointmentTimePicker.contentHorizontalAlignment = .center
        userBookingFormBirthDatePicker.maximumDate = Date()
        userAppointmentDatePicker.minimumDate = Date()
        userAppointmentTimePicker.minimumDate = Date()
    }
    
    private func setupDatePickerPlaceholders() {
        userAppointmentDatePicker.alpha = 0.0
        userAppointmentTimePicker.alpha = 0.0
        
        appointmentDatePlaceholderLabel.text = "Select date"
        appointmentDatePlaceholderLabel.setFontSize(.regular)
        appointmentDatePlaceholderLabel.textColor = .secondaryLabel
        appointmentDatePlaceholderLabel.isUserInteractionEnabled = true
        appointmentDatePlaceholderLabel.alpha = 1.0
        
        appointmentTimePlaceholderLabel.text = "Select time"
        appointmentTimePlaceholderLabel.setFontSize(.regular)
        appointmentTimePlaceholderLabel.textColor = .secondaryLabel
        appointmentTimePlaceholderLabel.isUserInteractionEnabled = true
        appointmentTimePlaceholderLabel.alpha = 1.0
        
        appointmentDatePlaceholderLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        )
        appointmentTimePlaceholderLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showTimePicker))
        )
    }
    
    private func setupTargets() {
        userBookingFormBirthDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        userAppointmentDatePicker.addTarget(self, action: #selector(appointmentDateChanged(_:)), for: .valueChanged)
        userAppointmentTimePicker.addTarget(self, action: #selector(appointmentTimeChanged(_:)), for: .valueChanged)
    }
    
    private func configureTextFields() {
        userBookingFormNameTextField.delegate = self
        userBookingFormPhoneNumberTextField.delegate = self
        userBookingFormMailTextField.delegate = self
    }
    private func setupServiceProviderName() {
        bookingServiceProviderLabel.text = viewModel.screenTitle
    }
    
    private func configureRadioButton() {
        genderRadioGroup.configure(options: ["Male", "Female"])
        genderRadioGroup.delegate = self
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
    
    @objc private func showDatePicker() {
        appointmentDatePlaceholderLabel.alpha = 0.0
        userAppointmentDatePicker.alpha = 1.0
        userAppointmentDatePicker.isUserInteractionEnabled = true
        updateMessageAfterPlaceholderTap()
    }
    
    @objc private func showTimePicker() {
        appointmentTimePlaceholderLabel.alpha = 0.0
        userAppointmentTimePicker.alpha = 1.0
        userAppointmentTimePicker.isUserInteractionEnabled = true
        updateMessageAfterPlaceholderTap()
    }
    
    private func updateMessageAfterPlaceholderTap() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let isDatePlaceholderVisible = appointmentDatePlaceholderLabel.alpha == 1.0
        let isTimePlaceholderVisible = appointmentTimePlaceholderLabel.alpha == 1.0
        
        switch (isDatePlaceholderVisible, isTimePlaceholderVisible) {
        case (true, true):
            appointmentMessageLabel.text = "Please select date and time for your appointment first."
            appointmentMessageLabel.textColor = .placeholderText
            
        case (false, true):
            appointmentMessageLabel.text = "Now select a time for your appointment."
            appointmentMessageLabel.textColor = .placeholderText
            
        case (true, false):
            appointmentMessageLabel.text = "Now select a date for your appointment."
            appointmentMessageLabel.textColor = .placeholderText
            
        case (false, false):
            let date = selectedAppointmentDate ?? Date(), time = selectedAppointmentTime ?? Date()
            appointmentMessageLabel.text = "Your appointment will be scheduled on \(dateFormatter.string(from: date)) at \(timeFormatter.string(from: time)). Please arrive 10 minutes early."
            appointmentMessageLabel.textColor = .placeholderText
        }
    }
    
    @objc private func appointmentDateChanged(_ picker: UIDatePicker) {
        selectedAppointmentDate = picker.date
        appointmentDatePlaceholderLabel.alpha = 0.0
        userAppointmentDatePicker.alpha = 1.0
        viewModel.updateAppointmentDate(picker.date)
        updateMessageAfterPlaceholderTap()
    }
    
    @objc private func appointmentTimeChanged(_ picker: UIDatePicker) {
        selectedAppointmentTime = picker.date
        appointmentTimePlaceholderLabel.alpha = 0.0
        userAppointmentTimePicker.alpha = 1.0
        viewModel.updateAppointmentTime(picker.date)
        updateMessageAfterPlaceholderTap()
    }
    
    private func updateMessageIfPickersVisible() {
        if userAppointmentDatePicker.alpha == 1.0 && userAppointmentTimePicker.alpha == 1.0 {
            let date = selectedAppointmentDate ?? Date()
            let time = selectedAppointmentTime ?? Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            
            appointmentMessageLabel.text = "Your appointment will be scheduled on \(dateFormatter.string(from: date)) at \(timeFormatter.string(from: time)). Please arrive 10 minutes early."
            appointmentMessageLabel.textColor = .placeholder
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func userBookingFormSubmitAction(_ sender: Any) {
        viewModel.submitAppointment()
    }
}

extension BookingFormViewController: RadioButtonGroupViewDelegate {
    func radioButtonGroup(_ group: RadioButtonGroupView, didSelect option: String) {
        viewModel.updateGender(option)
        viewModel.validateForm()
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
