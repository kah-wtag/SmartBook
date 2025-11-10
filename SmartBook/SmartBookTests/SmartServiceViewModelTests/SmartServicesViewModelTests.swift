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
    var mockBookingService: MockServicesBookingService!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockServicesDelegate()
        mockBookingService = MockServicesBookingService()
        sut = SmartServicesViewModel(service: mockBookingService)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        mockBookingService = nil
        super.tearDown()
    }
    
    func test_fetchServices_withEmptyServices_callsDidFail() {
        mockBookingService.mockServices = []
        sut.fetchServices()
        
        XCTAssertTrue(mockDelegate.didFailCalled)
        XCTAssertFalse(mockDelegate.didUpdateCalled)
        XCTAssertEqual(sut.numberOfServices, 0)
    }
    
    func test_fetchServices_withValidServices_callsDidUpdate() {
        let service = SmartService(serviceID: 1, serviceName: "Test Service", fields: [])
        mockBookingService.mockServices = [service]
        
        sut.fetchServices()
        
        XCTAssertTrue(mockDelegate.didUpdateCalled)
        XCTAssertFalse(mockDelegate.didFailCalled)
        XCTAssertEqual(sut.numberOfServices, 1)
        XCTAssertEqual(sut.serviceName(at: 0), "Test Service")
    }
    
    func test_serviceName_forInvalidIndex_returnsUnknown() {
        XCTAssertEqual(sut.serviceName(at: 0), "Unknown")
    }
    
    func test_serviceFieldsViewModel_forValidIndex_returnsViewModel() {
        let service = SmartService(serviceID: 1, serviceName: "Test Service", fields: [])
        mockBookingService.mockServices = [service]
        sut.fetchServices()
        
        let fieldsVM = sut.serviceFieldsViewModel(for: 0)
        XCTAssertNotNil(fieldsVM)
    }
    
    func test_serviceFieldsViewModel_forInvalidIndex_returnsNil() {
        let fieldsVM = sut.serviceFieldsViewModel(for: 5)
        XCTAssertNil(fieldsVM)
    }
}

final class MockServicesBookingService: SmartBookingServiceProtocol {
    var mockServices: [SmartService] = []
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {
        completion(mockServices.isEmpty ? nil : mockServices, nil)
    }
    
    func fetchFields(serviceID: Int, completion: @escaping ([SmartServiceField]?, Error?) -> Void) {}
    func fetchProviders(fieldTypeID: Int, completion: @escaping ([ServiceProvider]?, Error?) -> Void) {}
    func fetchAppointments(completion: @escaping ([Appointment]?, Error?) -> Void) {}
}

final class MockServicesDelegate: SmartServicesViewModelDelegate {
    var didUpdateCalled = false
    var didFailCalled = false
    
    func didUpdateServices() { didUpdateCalled = true }
    func didFailedWithError() { didFailCalled = true }
}
