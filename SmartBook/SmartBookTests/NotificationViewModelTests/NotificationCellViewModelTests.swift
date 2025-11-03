//
//  NotificationCellViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
@testable import SmartBook

final class NotificationCellViewModelTests: XCTestCase {

    func testCellViewModel_returnsCorrectData() {
        let now = Date()
        let formatter = DateFormatter.appointmentDateParser

        let appointment = Appointment(
            id: "1",
            serviceName: "Service Test",
            serviceFieldName: nil,
            providerName: "Provider Test",
            date: formatter.string(from: now),
            time: "12:00 PM"
        )

        let cellVM = NotificationCellViewModel(appointment: appointment)

        XCTAssertEqual(cellVM.serviceProviderName, "Provider Test")
        XCTAssertEqual(cellVM.timeText, "12:00 PM")
        XCTAssertEqual(cellVM.dateText, DateFormatter.displayFormatter.string(from: now))
    }

    func testCellViewModel_handlesNilValues() {
        let appointment = Appointment(
            id: "2",
            serviceName: nil,
            serviceFieldName: nil,
            providerName: nil,
            date: nil,
            time: nil
        )

        let cellVM = NotificationCellViewModel(appointment: appointment)

        XCTAssertEqual(cellVM.serviceProviderName, "Unknown")
        XCTAssertEqual(cellVM.timeText, "N/A")
        XCTAssertEqual(cellVM.dateText, "N/A")
    }
}
