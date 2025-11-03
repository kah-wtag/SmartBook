//
//  NotificationViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
@testable import SmartBook

final class NotificationViewModelTests: XCTestCase {

    var viewModel: NotificationViewModel!

    override func setUp() {
        super.setUp()
        viewModel = NotificationViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testSetAppointmentsForTesting_updatesAppointments() {
        let now = Date()
        let formatter = DateFormatter.appointmentDateParser

        let appointment = Appointment(
            id: "1",
            serviceName: "Service A",
            serviceFieldName: nil,
            providerName: "Provider A",
            date: formatter.string(from: now.addingTimeInterval(3600)), // within 7 days
            time: "10:00 AM"
        )

        var onDataCalled = false
        viewModel.onDataUpdated = { onDataCalled = true }

        viewModel.setAppointmentsForTesting([appointment])

        XCTAssertTrue(onDataCalled)
        XCTAssertEqual(viewModel.numberOfNotifications, 1)
        XCTAssertEqual(viewModel.upcomingAppointments.count, 1)
    }

    func testNotificationCellViewModel_returnsCorrectData() {
        let now = Date()
        let formatter = DateFormatter.appointmentDateParser
        let appointment = Appointment(
            id: "2",
            serviceName: "Service X",
            serviceFieldName: nil,
            providerName: "Provider X",
            date: formatter.string(from: now + 1),
            time: "11:00 AM"
        )

        viewModel.setAppointmentsForTesting([appointment])

        let cellVM = viewModel.notificationCellViewModel(at: 0)
        XCTAssertNotNil(cellVM)
        XCTAssertEqual(cellVM?.serviceProviderName, "Provider X")
        XCTAssertEqual(cellVM?.timeText, "11:00 AM")
        XCTAssertEqual(cellVM?.dateText, DateFormatter.displayFormatter.string(from: now))
    }

    func testNotificationCellViewModel_outOfRange_returnsNil() {
        viewModel.setAppointmentsForTesting([])
        XCTAssertNil(viewModel.notificationCellViewModel(at: 0))
    }
}
