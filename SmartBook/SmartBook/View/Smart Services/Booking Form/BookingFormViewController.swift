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
    
    private var selectedGender: String?
    private var bookingFormTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldTargets()
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
            field.verticalPadding()
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
    
    private func setupTextFieldTargets() {
        for textField in bookingFormTextFields {
            textField.addTarget(self, action: #selector(submitButtonActive(_:)), for: .editingChanged)
        }
    }
    
    @IBAction func userBookingFormGenderChoiceAction(_ sender: Any) {
        let alert = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .actionSheet)
        
        ["Male", "Female"].forEach { gender in
            alert.addAction(UIAlertAction(title: gender, style: .default) { _ in
                self.selectedGender = gender
                self.userBookingFormChoicedGenderLabel.text = gender
                self.submitButtonActive(self.userBookingFormNameTextField)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func isFormValid() -> Bool {
        let allTextFilled = bookingFormTextFields.allSatisfy {
            !($0.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty
        }
        let genderSelected = (selectedGender != nil)
        return allTextFilled && genderSelected
    }
    
    @objc private func submitButtonActive(_ textField: UITextField) {
        let formValid = isFormValid()
        appointmentSubmitButton.isEnabled = formValid
        appointmentSubmitButton.alpha = formValid ? 1.0 : 0.5
    }
    
    @IBAction func userBookingFormSubmitAction(_ sender: Any) {
        guard let name = userBookingFormNameTextField.text,
              let phone = userBookingFormPhoneNumberTextField.text,
              let email = userBookingFormMailTextField.text,
              let gender = selectedGender else { return }
        
        let dob = userBookingFormBirthDatePicker.date
        let appointmentDate = userAppointmentDateTimePicker.date
        
        print("Appointment Submitted")
        print("Name: \(name)")
        print("Phone: \(phone)")
        print("Email: \(email)")
        print("Gender: \(gender)")
        print("DOB: \(dob)")
        print("Appointment: \(appointmentDate)")
        
        Routes.displayBookedForm(from: navigationController)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

