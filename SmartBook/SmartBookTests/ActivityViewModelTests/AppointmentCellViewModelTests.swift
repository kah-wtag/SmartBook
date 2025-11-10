//
//  AppointmentCellViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
@testable import SmartBook

final class AppointmentCellViewModelTests: XCTestCase {
    
    private var sut: AppointmentCellViewModel!
    
    func test_serviceProviderName_returnsCorrectValue() {
        let appointment = Appointment(
            id: "1",
            serviceName: "Service A",
            serviceFieldName: nil,
            providerName: "Dr. Smith",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: Date()),
            time: "10:00 AM"
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        XCTAssertEqual(sut.serviceProviderName, "Dr. Smith")
    }
    
    func test_serviceProviderName_returnsUnknownIfNil() {
        let appointment = Appointment(
            id: "2",
            serviceName: "Service B",
            serviceFieldName: nil,
            providerName: nil,
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: Date()),
            time: "2:00 PM"
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        XCTAssertEqual(sut.serviceProviderName, "Unknown")
    }
    
    func test_appointmentDateText_formatsCorrectly() {
        let now = Date()
        let dateString = DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: now)
        
        let appointment = Appointment(
            id: "3",
            serviceName: "Service C",
            serviceFieldName: nil,
            providerName: "Provider C",
            date: dateString,
            time: "1:30 PM"
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        let expected = DateTimeHelper.formatter(for: DateFormat.dd_MMM_yyyy).string(from: now)
        XCTAssertEqual(sut.appointmentDateText, expected)
    }
    
    func test_appointmentDateText_returnsNAIfInvalidDate() {
        let appointment = Appointment(
            id: "4",
            serviceName: "Service D",
            serviceFieldName: nil,
            providerName: "Provider D",
            date: "invalid-date",
            time: "4:00 PM"
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        XCTAssertEqual(sut.appointmentDateText, "N/A")
    }
    
    func test_appointmentTimeText_returnsCorrectValue() {
        let appointment = Appointment(
            id: "5",
            serviceName: "Service E",
            serviceFieldName: nil,
            providerName: "Provider E",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: Date()),
            time: "3:45 PM"
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        XCTAssertEqual(sut.appointmentTimeText, "3:45 PM")
    }
    
    func test_appointmentTimeText_returnsNAIfNil() {
        let appointment = Appointment(
            id: "6",
            serviceName: "Service F",
            serviceFieldName: nil,
            providerName: "Provider F",
            date: DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: Date()),
            time: nil
        )
        
        sut = AppointmentCellViewModel(appointment: appointment)
        XCTAssertEqual(sut.appointmentTimeText, "N/A")
    }
}
