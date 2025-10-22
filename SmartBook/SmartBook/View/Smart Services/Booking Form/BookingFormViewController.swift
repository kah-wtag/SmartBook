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
    @IBOutlet var scrollView: UIScrollView!
    
    let viewModel = BookingFormViewModel()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        registerForKeyboardNotifications()
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
        appointmentMessageLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        basicInformationLabel.setFontSize(.large, weight: .regular, dynamic: true)
        bookingServiceProviderLabel.setFontSize(.large, weight: .bold, dynamic: true)
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
        
        let minDate = Date() + viewModel.minAdvanceTime
        userAppointmentDatePicker.minimumDate = minDate
        userAppointmentTimePicker.minimumDate = minDate
    }
    
    private func setupDatePickerPlaceholders() {
        userAppointmentDatePicker.alpha = 0.0
        userAppointmentTimePicker.alpha = 0.0
        
        appointmentDatePlaceholderLabel.text = "Select date"
        appointmentDatePlaceholderLabel.setFontSize(.regular)
        appointmentDatePlaceholderLabel.textColor = .primaryText
        appointmentDatePlaceholderLabel.isUserInteractionEnabled = true
        appointmentDatePlaceholderLabel.alpha = 1.0
        
        appointmentTimePlaceholderLabel.text = "Select time"
        appointmentTimePlaceholderLabel.setFontSize(.regular)
        appointmentTimePlaceholderLabel.textColor = .primaryText
        appointmentTimePlaceholderLabel.isUserInteractionEnabled = true
        appointmentTimePlaceholderLabel.alpha = 1.0
        
        appointmentDatePlaceholderLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        )
        appointmentTimePlaceholderLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showTimePicker))
        )
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset.bottom = keyboardHeight + 16
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let rect = textField.convert(textField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
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
        bookingServiceProviderLabel.text = viewModel.serviceProvidersName
    }
    
    private func configureRadioButton() {
        genderRadioGroup.configure(options: ["Male", "Female"], preselectedOption: viewModel.gender)
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
        default: break
        }
        
        return true
    }
    
    @objc private func dateChanged(_ picker: UIDatePicker) {
        viewModel.updateDateOfBirth(picker.date)
    }
    
    @objc private func showDatePicker() {
        appointmentDatePlaceholderLabel.alpha = 0.0
        userAppointmentDatePicker.alpha = 1.0
        userAppointmentDatePicker.isUserInteractionEnabled = true
        if selectedAppointmentDate == nil {
            selectedAppointmentDate = userAppointmentDatePicker.date
            viewModel.updateAppointmentDate(userAppointmentDatePicker.date)
        }
        updateMessageAfterPlaceholderTap()
    }
    
    @objc private func showTimePicker() {
        appointmentTimePlaceholderLabel.alpha = 0.0
        userAppointmentTimePicker.alpha = 1.0
        userAppointmentTimePicker.isUserInteractionEnabled = true
        if selectedAppointmentTime == nil {
            selectedAppointmentTime = userAppointmentTimePicker.date
            viewModel.updateAppointmentTime(userAppointmentTimePicker.date)
        }
        updateMessageAfterPlaceholderTap()
    }
    
    private func updateMessageAfterPlaceholderTap() {
        let result = viewModel.getAppointmentMessage(
            isDateSelected: appointmentDatePlaceholderLabel.alpha == 0.0,
            isTimeSelected: appointmentTimePlaceholderLabel.alpha == 0.0
        )
        appointmentMessageLabel.text = result.text
        appointmentMessageLabel.textColor = result.color
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
        let canSubmit = isValid && appointmentMessageLabel.textColor == .reverseWarning
        appointmentSubmitButton.isEnabled = canSubmit
        appointmentSubmitButton.alpha = canSubmit ? 1.0 : 0.5
        appointmentSubmitButton.layer.borderColor = (canSubmit ? UIColor.border : UIColor.placeholder).cgColor
    }
    
    func didUpdateFieldValidation(for field: BookingFormViewModel.BookingField) {
        updateBorder(for: field, isValid: isFieldValid(field))
    }
    
    private func isFieldValid(_ field: BookingFormViewModel.BookingField) -> Bool {
        switch field {
        case .name:
            viewModel.isNameValid
        case .phone:
            viewModel.isPhoneValid
        case .email:
            viewModel.isEmailValid
        }
    }
    
    private func updateBorder(for field: BookingFormViewModel.BookingField, isValid: Bool) {
        let color = isValid ? UIColor.textfield.cgColor : UIColor.warning.cgColor
        
        switch field {
        case .name:
            userBookingFormNameTextField.layer.borderColor = color
        case .phone:
            userBookingFormPhoneNumberTextField.layer.borderColor = color
        case .email:
            userBookingFormMailTextField.layer.borderColor = color
        }
    }
    
    func didSubmitAppointment() {
        let bookedFormVC = Routes.bookedFormVC
        bookedFormVC.appointmentDate = viewModel.bookedDate
        bookedFormVC.appointmentTime = viewModel.bookedTime
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(bookedFormVC, animated: true)
    }
}
