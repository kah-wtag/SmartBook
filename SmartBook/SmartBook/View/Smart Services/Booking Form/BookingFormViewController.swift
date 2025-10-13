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
    @IBOutlet var maleCircle: RadioCircleView!
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femaleCircle: RadioCircleView!
    @IBOutlet var femaleButton: UIButton!
    
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
        setupGenderCircleGestures()
    }
    
    private func setupGenderCircleGestures() {
        let maleTap = UITapGestureRecognizer(target: self, action: #selector(maleCircleTapped))
        maleCircle.addGestureRecognizer(maleTap)
        maleCircle.isUserInteractionEnabled = true

        let femaleTap = UITapGestureRecognizer(target: self, action: #selector(femaleCircleTapped))
        femaleCircle.addGestureRecognizer(femaleTap)
        femaleCircle.isUserInteractionEnabled = true
    }
    
    @objc private func maleCircleTapped() {
        selectGender("Male")
    }

    @objc private func femaleCircleTapped() {
        selectGender("Female")
    }

    private func selectGender(_ gender: String) {
        maleCircle.isSelected = (gender == "Male")
        femaleCircle.isSelected = (gender == "Female")
        viewModel.updateGender(gender)
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
        setupTextFields()
        setupSubmitButton()
        setupFontSize()
        setupTextColor()
        setupDatePicker()
    }
    
    private func setupDatePicker() {
        userBookingFormBirthDatePicker.contentHorizontalAlignment = .center
        userAppointmentDatePicker.contentHorizontalAlignment = .center
        userAppointmentTimePicker.contentHorizontalAlignment = .center
    }
    
    private func setupTextFields() {
        userBookingFormNameTextField.setStyledPlaceholder("Full Name")
        userBookingFormNameTextField.textFieldStyle(dynamic: true)
        userBookingFormNameTextField .verticalPadding([.left, .right], width: 8)
        userBookingFormMailTextField.setStyledPlaceholder("Email Address")
        userBookingFormMailTextField.textFieldStyle(dynamic: true)
        userBookingFormMailTextField .verticalPadding([.left, .right], width: 8)
        userBookingFormPhoneNumberTextField.setStyledPlaceholder("Phone Number")
        userBookingFormPhoneNumberTextField.textFieldStyle(dynamic: true)
        userBookingFormPhoneNumberTextField .verticalPadding([.left, .right], width: 8)
    }
    
    private func setupSubmitButton() {
        appointmentSubmitButton.applyRoundBorder(color: .placeholder)
        appointmentSubmitButton.isEnabled = false
        appointmentSubmitButton.alpha = 0.5
    }
    
    private func setupFontSize() {
        maleButton.setFontSize(.large, weight: .medium, dynamic: true)
        femaleButton.setFontSize(.large, weight: .medium, dynamic: true)
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
        dateOfBirthLabel.textColor = .primaryText
        gendarLabel.textColor = .primaryText
        dateTimeLabel.textColor = .primaryText
        maleButton.tintColor = .secondaryLabel
        femaleButton.tintColor = .secondaryLabel
    }
    
    private func setupServiceProviderName() {
        bookingServiceProviderLabel.text = viewModel.screenTitle
    }
    
    private func setupTargets() {
        userBookingFormBirthDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        userAppointmentDatePicker.addTarget(self, action: #selector(appointmentDateChanged(_:)), for: .valueChanged)
        userAppointmentTimePicker.addTarget(self, action: #selector(appointmentTimeChanged(_:)), for: .valueChanged)
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
    
    @objc private func appointmentTimeChanged(_ picker: UIDatePicker) {
        viewModel.updateAppointmentTime(picker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func maleButtonTapped(_ sender: UIButton) {
        maleCircle.isSelected = true
        femaleCircle.isSelected = false
    }

    @IBAction func femaleButtonTapped(_ sender: UIButton) {
        maleCircle.isSelected = false
        femaleCircle.isSelected = true
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
