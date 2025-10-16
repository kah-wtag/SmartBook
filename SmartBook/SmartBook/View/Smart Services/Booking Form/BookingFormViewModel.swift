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
}

final class BookingFormViewModel {
    
    weak var delegate: BookingFormViewModelDelegate?
    
    private(set) var screenTitle: String = ""
    private(set) var name: String = ""
    private(set) var phone: String = ""
    private(set) var email: String = ""
    private var selectedGender: String? = nil
    private(set) var dateOfBirth: Date = Date()
    private(set) var appointmentDate: Date = Date()
    private(set) var appointmentTime: Date = Date()
    
    private var isFormValid: Bool = false {
        didSet {
            delegate?.didUpdateFormValidity(isValid: isFormValid)
        }
    }
    
    func setDoctorName(_ name: String?) {
        screenTitle = "Book Appointment with \(name ?? "unknown")"
    }
    
    func updateName(_ text: String?) {
        name = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    func updatePhone(_ text: String?) {
        phone = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    func updateEmail(_ text: String?) {
        email = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    func updateGender(_ gender: String) {
        selectedGender = gender
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
        let allFieldsFilled = !name.isEmpty && !phone.isEmpty && !email.isEmpty
        let genderChosen = (selectedGender != nil)
        let emailValid = EmailValidation.isValid(email)
        isFormValid = allFieldsFilled && genderChosen && emailValid
    }
    
    func isEmailValid() -> Bool {
        return EmailValidation.isValid(email)
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
                " (Less than 10 minutes remaining)" :
                " (Less than 5 minutes remaining)"
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
            
            let message = "Your appointment will be scheduled on \(dateFormatter.string(from: appointmentDate)) at \(timeFormatter.string(from: appointmentTime)). Fill in your information and press Submit to finalize the booking. \(remainingText)"
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
