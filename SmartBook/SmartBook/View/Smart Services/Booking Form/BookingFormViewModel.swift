//
//  BookingFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import UIKit

protocol BookingFormViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didSubmitAppointment()
    func didUpdateFieldValidation(for field: BookingFormViewModel.BookingField)
}

final class BookingFormViewModel {
    
    enum BookingField { case name, phone, email }
    
    private var serviceProviderName = ""
    private var name = ""
    private var phone = ""
    private var email = ""
    private var dateOfBirth = Date()
    private var appointmentDate = Date()
    private var appointmentTime = Date()
    private var minimumAdvanceTime: TimeInterval = 0
    private var selectedGender: String? = nil
    
    weak var delegate: BookingFormViewModelDelegate?
    
    private var isFormValid: Bool = false {
        didSet {
            delegate?.didUpdateFormValidity(isValid: isFormValid)
        }
    }
    
    var gender: String? {
        return selectedGender
    }
    var minAdvanceTime: TimeInterval {
        minimumAdvanceTime
    }
    var screenTitle: String {
        serviceProviderName
    }
    var isNameValid: Bool {
        name.isValidName()
    }
    var isPhoneValid: Bool {
        phone.isValidPhone()
    }
    var isEmailValid: Bool {
        email.isValidEmail()
    }
    var isGenderSelected: Bool {
        selectedGender != nil
    }
    var bookedDate: Date {
        return appointmentDate
    }
    var bookedTime: Date {
        return appointmentTime
    }
    var minimumAppointmentDate: Date {
        let now = Date()
        guard let advanceTime = serviceProvider?.minimumAdvanceTime else { return now }
        return now + advanceTime
    }
    var serviceProvider: ServiceProvider?
    
    func setServiceProvider(_ provider: ServiceProvider) {
        serviceProvider = provider
    }
    
    func setMinimumAdvanceTime(_ time: TimeInterval?) {
        minimumAdvanceTime = time ?? 0
    }
    
    func setServiceProviderName(_ name: String?) {
        serviceProviderName = "Book Appointment with \(name ?? "unknown")"
    }
    
    func updateName(_ text: String?) {
        name = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        delegate?.didUpdateFieldValidation(for: .name)
        validateForm()
    }
    
    func updatePhone(_ text: String?) {
        phone = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        delegate?.didUpdateFieldValidation(for: .phone)
        validateForm()
    }
    
    func updateEmail(_ text: String?) {
        email = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        delegate?.didUpdateFieldValidation(for: .email)
        validateForm()
    }
    
    func updateGender(_ gender: String) {
        selectedGender = gender
        validateForm()
    }
    
    func updateDateOfBirth(_ date: Date) {
        dateOfBirth = date
    }
    
    func updateAppointmentDate(_ date: Date) {
        appointmentDate = date
    }
    
    func updateAppointmentTime(_ time: Date) {
        appointmentTime = time
    }
    
    func validateForm() {
        isFormValid = isNameValid && isPhoneValid && isEmailValid && isGenderSelected
    }
    
    func getAppointmentMessage(isDateSelected: Bool, isTimeSelected: Bool) -> (text: String, color: UIColor) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        switch (isDateSelected, isTimeSelected) {
        case (false, false):
            return ("Please select date and time for your appointment first.", .warning)
        case (true, false):
            return ("Now select a time for your appointment.", .warning)
        case (false, true):
            return ("Now select a date for your appointment.", .warning)
        case (true, true):
            let message = "Your appointment will be scheduled on \(dateFormatter.string(from: appointmentDate)) at \(timeFormatter.string(from: appointmentTime))."
            return (message, .reverseWarning)
        }
    }
    
    func submitAppointment() {
        delegate?.didSubmitAppointment()
        print("""
              Appointment Submitted
              Name: \(name)
              Phone: \(phone)
              Email: \(email)
              Gender: \(selectedGender ?? "N/A")
              DOB: \(dateOfBirth)
              Appointment: \(appointmentDate)
              """)
    }
}
