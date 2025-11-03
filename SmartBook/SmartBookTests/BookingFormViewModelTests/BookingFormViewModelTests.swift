//
//  BookingFormViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 03/11/25.
//

import XCTest
@testable import SmartBook

final class BookingFormViewModelTests: XCTestCase {
    
    private var sut: BookingFormViewModel!
    private var mockDelegate: MockBookingFormDelegate!
    private var mockProvider: ServiceProvider!
    
    override func setUp() {
        super.setUp()
        
        mockProvider = ServiceProvider(
            name: "Dr. John",
            experience: 10,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: 50,
            bio: "Cardiologist",
            degrees: ["MBBS", "MD"],
            institution: "City Hospital",
            minimumAdvanceTime: 3600
        )
        
        sut = BookingFormViewModel()
        sut.setServiceProvider(mockProvider)
        
        mockDelegate = MockBookingFormDelegate()
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        mockProvider = nil
        super.tearDown()
    }
    
    func test_setServiceProviderName_setsCorrectName() {
        sut.setServiceProviderName("Dr. John")
        
        XCTAssertEqual(sut.serviceProvidersName, "Book Appointment with Dr. John")
    }
    
    func test_updateName_trimsAndValidates() {
        sut.updateName("  Alice  ")
        
        XCTAssertTrue(sut.isNameValid)
        XCTAssertEqual(mockDelegate.updatedField, .name)
    }
    
    func test_updatePhone_trimsAndValidates() {
        sut.updatePhone(" +880173456789 ")
        
        XCTAssertTrue(sut.isPhoneValid)
        XCTAssertEqual(mockDelegate.updatedField, .phone)
    }
    
    func test_updateEmail_trimsAndValidates() {
        sut.updateEmail(" test@example.com ")
        
        XCTAssertTrue(sut.isEmailValid)
        XCTAssertEqual(mockDelegate.updatedField, .email)
    }
    
    func test_updateGender_updatesGenderAndValidatesForm() {
        sut.updateGender("Male")
        
        XCTAssertTrue(sut.isGenderSelected)
        XCTAssertTrue(mockDelegate.formValidityCalled)
    }
    
    func test_validateForm_setsFormValidityCorrectly() {
        sut.updateName("Alice")
        sut.updatePhone("+880123456789")
        sut.updateEmail("test@example.com")
        sut.updateGender("Female")
        
        sut.validateForm()
        
        XCTAssertTrue(mockDelegate.lastFormValidity)
    }
    
    func test_minimumAppointmentDate_calculatesCorrectly() {
        let minDate = sut.minimumAppointmentDate
        let expected = mockProvider.minimumAdvanceTime ?? 0
        let tolerance: TimeInterval = 0.1 
        
        XCTAssertGreaterThanOrEqual(minDate.timeIntervalSinceNow + tolerance, expected)
    }
    
    func test_getAppointmentMessage_returnsCorrectMessages() {
        var message = sut.getAppointmentMessage(isDateSelected: false, isTimeSelected: false)
        XCTAssertTrue(message.text.contains("Please select date and time"))
        
        message = sut.getAppointmentMessage(isDateSelected: true, isTimeSelected: false)
        XCTAssertTrue(message.text.contains("Now select a time"))
        
        message = sut.getAppointmentMessage(isDateSelected: false, isTimeSelected: true)
        XCTAssertTrue(message.text.contains("Now select a date"))
        
        message = sut.getAppointmentMessage(isDateSelected: true, isTimeSelected: true)
        XCTAssertTrue(message.text.contains("Your appointment will be scheduled on"))
    }
    
    func test_submitAppointment_callsDelegate() {
        sut.updateName("Alice")
        sut.updatePhone("0123456789")
        sut.updateEmail("test@example.com")
        sut.updateGender("Female")
        sut.updateAppointmentDate(Date())
        sut.updateAppointmentTime(Date())
        sut.submitAppointment()
        
        XCTAssertTrue(mockDelegate.didSubmitCalled)
    }
}

final class MockBookingFormDelegate: BookingFormViewModelDelegate {
    
    var updatedField: BookingFormViewModel.BookingField?
    var formValidityCalled = false
    var lastFormValidity = false
    var didSubmitCalled = false
    
    func didUpdateFormValidity(isValid: Bool) {
        formValidityCalled = true
        lastFormValidity = isValid
    }
    
    func didSubmitAppointment() {
        didSubmitCalled = true
    }
    
    func didUpdateFieldValidation(for field: BookingFormViewModel.BookingField) {
        updatedField = field
    }
}
