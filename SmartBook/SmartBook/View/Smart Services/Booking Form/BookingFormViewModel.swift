//
//  BookingFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import UIKit

protocol BookingFormViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didSelectGender(_ gender: String)
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
        delegate?.didSelectGender(gender)
    }
    
    func updateDateOfBirth(_ date: Date) {
        dateOfBirth = date
    }
    
    func updateAppointmentDate(_ date: Date) {
        appointmentDate = date
    }
    
    func validateForm() {
        let allFieldsFilled = !name.isEmpty && !phone.isEmpty && !email.isEmpty
        let genderChosen = (selectedGender != nil)
        isFormValid = allFieldsFilled && genderChosen
    }
    
    func submitAppointment() {
        print("""
              Appointment Submitted
              Name: \(name)
              Phone: \(phone)
              Email: \(email)
              Gender: \(selectedGender ?? "N/A")
              DOB: \(dateOfBirth)
              Appointment: \(appointmentDate)
              """)
        delegate?.didSubmitAppointment()
    }
}
