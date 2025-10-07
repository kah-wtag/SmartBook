//
//  BookingFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import Foundation
import UIKit

protocol BookingFormViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didSelectGender(_ gender: String)
    func didSubmitAppointment()
}

final class BookingFormViewModel {
    
    weak var delegate: BookingFormViewModelDelegate?
    private(set) var doctorName: String = ""
    private(set) var name: String = "" {
        didSet { validateForm() }
    }
    private(set) var phone: String = "" {
        didSet { validateForm() }
    }
    private(set) var email: String = "" {
        didSet { validateForm() }
    }
    private(set) var selectedGender: String? {
        didSet {
            validateForm()
            if let gender = selectedGender {
                delegate?.didSelectGender(gender)
            }
        }
    }
    private(set) var dateOfBirth: Date = Date()
    private(set) var appointmentDate: Date = Date()
    
    private var isFormValid: Bool = false {
        didSet {
            delegate?.didUpdateFormValidity(isValid: isFormValid)
        }
    }
    
    func setDoctorName(_ name: String) {
        doctorName = "Book \(name)"
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
    
    private func validateForm() {
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
