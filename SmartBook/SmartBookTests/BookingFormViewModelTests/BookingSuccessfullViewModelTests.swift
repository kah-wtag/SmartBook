//
//  BookingSuccessfullViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/11/25.
//

import XCTest
@testable import SmartBook

final class BookingSuccessfullViewModelTests: XCTestCase {
    
    private var sut: BookedFormViewModel!
    private var appointmentDate: Date!
    private var appointmentTime: Date!
    
    override func setUp() {
        super.setUp()
        appointmentDate = Date(timeIntervalSince1970: 1_700_000_000)
        appointmentTime = Date(timeIntervalSince1970: 1_700_000_000 + 3600)
        
        sut = BookedFormViewModel(appointmentDate: appointmentDate, appointmentTime: appointmentTime)
    }
    
    override func tearDown() {
        sut = nil
        appointmentDate = nil
        appointmentTime = nil
        super.tearDown()
    }
    
    func test_bookingConfirmationMessage_formatsCorrectly() {
        let message = sut.bookingConfirmationMessage
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let expectedMessage = "Your appointment is scheduled on \(dateFormatter.string(from: appointmentDate)) at \(timeFormatter.string(from: appointmentTime))."
        
        XCTAssertEqual(message, expectedMessage)
    }
    
    func test_goToHome_callsRoutes() {
        sut.goToHome()
    }
    
    func test_bookingTitles_areCorrect() {
        XCTAssertEqual(sut.bookingSuccessTitle, "Congratulations!!")
        XCTAssertEqual(sut.goHomeButtonTitle, "Go to Services")
    }
}
