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

        let appointment = Appointment(
            id: "1",
            serviceName: "Service Test",
            serviceFieldName: nil,
            providerName: "Provider Test",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: now),
            time: "12:00 PM"
        )

        let cellVM = NotificationCellViewModel(appointment: appointment)
        let message = cellVM.notificationMessage.string

        XCTAssertTrue(message.contains("Provider Test"))
        XCTAssertTrue(message.contains(DateTimeHelper.formatter(for: DateFormat.dd_MMM_yyyy).string(from: now)))
        XCTAssertTrue(message.contains("12:00 PM"))
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
        let message = cellVM.notificationMessage.string

        XCTAssertTrue(message.contains("Unknown"))
        XCTAssertTrue(message.contains("N/A"))
    }

    func testShowUnreadIcon_defaultsToTrue() {
        let appointment = Appointment(
            id: "3",
            serviceName: nil,
            serviceFieldName: nil,
            providerName: nil,
            date: nil,
            time: nil
        )

        let cellVM = NotificationCellViewModel(appointment: appointment)
        XCTAssertTrue(cellVM.showUnreadIcon)
    }
}
