//
//  AppointmentListViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
@testable import SmartBook

final class AppointmentListViewModelTest: XCTestCase {
    
    private var sut: AppointmentListViewModel!
    private var mockDelegate: MockAppointmentListViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        sut = AppointmentListViewModel()
        mockDelegate = MockAppointmentListViewModelDelegate()
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func test_setAppointmentsForTesting_updatesAppointments() {
        let appointment1 = Appointment(
            id: "1",
            serviceName: "Service A",
            serviceFieldName: nil,
            providerName: nil,
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z)
                .string(from: Date().addingTimeInterval(3600)),
            time: nil
        )
        
        let appointment2 = Appointment(
            id: "2",
            serviceName: "Service B",
            serviceFieldName: nil,
            providerName: nil,
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z)
                .string(from: Date().addingTimeInterval(-3600)),
            time: nil
        )
        
        sut.setAppointmentsForTesting([appointment1, appointment2])
        
        XCTAssertEqual(sut.numberOfUpcomingAppointments, 1)
        XCTAssertEqual(sut.numberOfPastAppointments, 1)
        XCTAssertTrue(mockDelegate.didUpdateCalled)
    }
    
    func test_setAppointmentsForTesting_withError_callsDelegate() {
        let error = NSError(domain: "Test", code: 0)
        sut.setAppointmentsForTesting(nil, error: error)
        XCTAssertTrue(mockDelegate.didFailCalled)
        XCTAssertEqual(mockDelegate.capturedError as NSError?, error)
    }
}

final class MockAppointmentListViewModelDelegate: AppointmentListViewModelDelegate {
    var didUpdateCalled = false
    var didFailCalled = false
    var capturedError: Error?
    
    func didUpdateAppointments() {
        didUpdateCalled = true
    }
    
    func didFailFetchingAppointments(with error: Error) {
        didFailCalled = true
        capturedError = error
    }
}
