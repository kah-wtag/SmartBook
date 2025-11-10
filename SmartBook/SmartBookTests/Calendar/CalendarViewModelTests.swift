//
//  CalendarViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
@testable import SmartBook

final class CalendarViewModelTests: XCTestCase {
    
    private var appointmentListVM: AppointmentListViewModel!
    private var calendarVM: CalendarViewModel!
    
    override func setUp() {
        super.setUp()
        
        appointmentListVM = AppointmentListViewModel()
        calendarVM = CalendarViewModel(appointmentListVM: appointmentListVM)
        
        let now = Date()
        let futureDateStr = DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: now.addingTimeInterval(3600))
        let pastDateStr = DateTimeHelper.formatter(for: DateFormat.yyyy_MM_dd_HH_mm_ss_Z).string(from: now.addingTimeInterval(-3600))
        
        let futureAppointment = Appointment(
            id: "1",
            serviceName: "Service A",
            serviceFieldName: nil,
            providerName: "Provider X",
            date: futureDateStr,
            time: "10:00 AM"
        )
        
        let pastAppointment = Appointment(
            id: "2",
            serviceName: "Service B",
            serviceFieldName: nil,
            providerName: "Provider Y",
            date: pastDateStr,
            time: "09:00 AM"
        )
        
        appointmentListVM.setAppointmentsForTesting([futureAppointment, pastAppointment])
    }
    
    override func tearDown() {
        appointmentListVM = nil
        calendarVM = nil
        super.tearDown()
    }
    
    func testNumberOfUpcomingAppointments() {
        XCTAssertEqual(calendarVM.numberOfUpcomingAppointments, 1)
    }
    
    func testHasAppointmentOnDate() {
        let now = Date()
        let calendar = Calendar.current
        
        let hasAppointment = calendarVM.hasAppointment(on: now)
        XCTAssertTrue(hasAppointment)
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: now)!
        XCTAssertFalse(calendarVM.hasAppointment(on: yesterday))
    }
    
    func testAllUpcomingDateComponents() {
        let components = calendarVM.allUpcomingDateComponents()
        XCTAssertEqual(components.count, 1)
        
        let expectedComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date().addingTimeInterval(3600))
        XCTAssertEqual(components.first?.year, expectedComponents.year)
        XCTAssertEqual(components.first?.month, expectedComponents.month)
        XCTAssertEqual(components.first?.day, expectedComponents.day)
    }
    
    func testDisplayTextForUpcomingAppointment() {
        let text = calendarVM.displayText(for: 0)
        XCTAssertTrue(text.contains("Provider X"))
        XCTAssertTrue(text.contains("10:00 AM"))
        
        let expectedDate = DateTimeHelper.formatter(for: DateFormat.dd_MMM_yyyy).string(from: Date().addingTimeInterval(3600))
        XCTAssertTrue(text.contains(expectedDate))
    }
    
    func testDisplayTextOutOfBounds() {
        let text = calendarVM.displayText(for: 5)
        XCTAssertEqual(text, "N/A")
    }
}
