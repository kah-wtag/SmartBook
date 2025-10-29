//
//  SmartServicesViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/10/25.
//

import XCTest
@testable import SmartBook

final class SmartServicesViewModelTests: XCTestCase {
    var sut: SmartServicesViewModel!
    var mockDelegate: MockServicesDelegate!
    var mockBookingService: MockSmartBookingService!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockServicesDelegate()
        mockBookingService = MockSmartBookingService()
        sut = SmartServicesViewModel(service: mockBookingService)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockBookingService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func test_fetchServices_success_shouldUpdateDelegate() {
        mockBookingService.mockServices = [
            SmartService(serviceID: 1, serviceName: "Haircut", fields: []),
            SmartService(serviceID: 2, serviceName: "Massage", fields: [])
        ]
        
        sut.fetchServices()
        
        XCTAssertTrue(mockDelegate.didUpdateServicesCalled)
        XCTAssertFalse(mockDelegate.didFailWithErrorCalled)
        XCTAssertEqual(sut.numberOfServices, 2)
        XCTAssertEqual(sut.serviceName(at: 0), "Haircut")
        XCTAssertEqual(sut.serviceName(at: 1), "Massage")
    }
    
    func test_fetchServices_failure_shouldNotifyError() {
        mockBookingService.shouldReturnError = true
        
        sut.fetchServices()
        
        XCTAssertTrue(mockDelegate.didFailWithErrorCalled)
        XCTAssertFalse(mockDelegate.didUpdateServicesCalled)
    }
    
    func test_serviceName_outOfRange_returnsUnknown() {
        XCTAssertEqual(sut.serviceName(at: 99), "Unknown")
    }
}

final class MockSmartBookingService: SmartBookingServiceProtocol {
    var mockServices: [SmartService] = []
    var shouldReturnError = false
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {
        if shouldReturnError {
            completion(nil, NSError(domain: "TestErro
