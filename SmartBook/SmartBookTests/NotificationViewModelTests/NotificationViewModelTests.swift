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
        let appointment = Appointment(
            id: "1",
            serviceName: "Service A",
            serviceFieldName: nil,
            providerName: "Provider A",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z)
                .string(from: now.addingTimeInterval(3600)), // within 7 days
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
        let appointment = Appointment(
            id: "2",
            serviceName: "Service X",
            serviceFieldName: nil,
            providerName: "Provider X",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z)
                .string(from: now.addingTimeInterval(1)),
            time: "11:00 AM"
        )

        viewModel.setAppointmentsForTesting([appointment])

        let cellVM = viewModel.notificationCellViewModel(at: 0)
        XCTAssertNotNil(cellVM)

        let message = cellVM?.notificationMessage.string
        XCTAssertNotNil(message)
        XCTAssertTrue(message?.contains("Provider X") ?? false)
        XCTAssertTrue(message?.contains("11:00 AM") ?? false)
        XCTAssertTrue(message?.contains(DateTimeHelper.formatter(for: DateFormat.dd_MMM_yyyy).string(from: now)) ?? false)
    }

    func testNotificationCellViewModel_outOfRange_returnsNil() {
        viewModel.setAppointmentsForTesting([])
        XCTAssertNil(viewModel.notificationCellViewModel(at: 0))
    }
}
