//
//  BookingFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import UIKit

protocol BookingFormViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didSubmitAppointment(with message: String)
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
        isFormValid = allFieldsFilled && genderChosen
    }
    
    func submitAppointment() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let date = dateFormatter.string(from: appointmentDate)
        let time = timeFormatter.string(from: appointmentTime)
        
        let message = """
    Your appointment has been successfully scheduled for \(date) at \(time).
    Please contact 01749-140494 if you have any questions or need to modify your schedule.
    """
        delegate?.didSubmitAppointment(with: message)
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
