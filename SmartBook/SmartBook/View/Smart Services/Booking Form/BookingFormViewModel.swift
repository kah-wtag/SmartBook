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
    
    enum BookingField {
        case name
        case phone
        case email
    }
    
    weak var delegate: BookingFormViewModelDelegate?
    
    private(set) var serviceProviderName: String = ""
    private(set) var name: String = ""
    private(set) var phone: String = ""
    private(set) var email: String = ""
    private(set) var dateOfBirth: Date = Date()
    private(set) var appointmentDate: Date = Date()
    private(set) var appointmentTime: Date = Date()
    private(set) var minimumAdvanceTime: TimeInterval = 0
    
    private var selectedGender: String? = nil
    private var isFormValid: Bool = false {
        didSet {
            delegate?.didUpdateFormValidity(isValid: isFormValid)
        }
    }
    
    var isNameValid: Bool { NameValidation.isValid(name) }
    var isPhoneValid: Bool { PhoneValidation.isValid(phone) }
    var isEmailValid: Bool { EmailValidation.isValid(email) }
    var isGenderSelected: Bool { selectedGender != nil }
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
    
    private var combinedAppointmentDateTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: appointmentDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: appointmentTime)
        var merged = DateComponents()
        merged.year = dateComponents.year
        merged.month = dateComponents.month
        merged.day = dateComponents.day
        merged.hour = timeComponents.hour
        merged.minute = timeComponents.minute
        
        return calendar.date(from: merged) ?? appointmentDate
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
            let calendar = Calendar.current
            let appointmentDateTime = calendar.date(
                bySettingHour: calendar.component(.hour, from: appointmentTime),
                minute: calendar.component(.minute, from: appointmentTime),
                second: 0,
                of: appointmentDate
            ) ?? Date()
            
            let interval = Int(appointmentDateTime.timeIntervalSinceNow)
            let remainingMinutes = max(0, interval / 60)
            let remainingText: String
            
            if remainingMinutes < 10 {
                remainingText = remainingMinutes >= 5 ?
                " (Less than 10 minutes will be remained)" :
                " (Less than 5 minutes will be remained)"
            } else {
                let days = remainingMinutes / (24 * 60)
                let hours = (remainingMinutes % (24 * 60)) / 60
                let minutes = remainingMinutes % 60
                var parts: [String] = []
                if days > 0 { parts.append("\(days)d") }
                if hours > 0 { parts.append("\(hours)h") }
                if minutes > 0 { parts.append("\(minutes)m") }
                remainingText = "(\(parts.joined(separator: " ")) remaining)"
            }
            
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
