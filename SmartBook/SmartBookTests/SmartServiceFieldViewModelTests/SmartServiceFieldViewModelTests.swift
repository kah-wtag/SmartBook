//
//  SmartServiceFieldsViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/11/25.
//

import XCTest
@testable import SmartBook

final class SmartServiceFieldsViewModelTests: XCTestCase {
    
    var sut: SmartServiceFieldsViewModel!
    var mockDelegate: MockServiceFieldsDelegate!
    var mockBookingService: MockFieldsBookingService!
    var mockService: SmartService!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockServiceFieldsDelegate()
        mockBookingService = MockFieldsBookingService()
        mockService = SmartService(serviceID: 1, serviceName: "Test Service", fields: [])
        sut = SmartServiceFieldsViewModel(service: mockService, bookingService: mockBookingService)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockDelegate = nil
        mockBookingService = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_fetchFields_withEmptyFields_callsDidFail() {
        mockBookingService.mockFields = []
        sut.fetchFields()
        
        XCTAssertTrue(mockDelegate.didFailCalled)
        XCTAssertFalse(mockDelegate.didUpdateCalled)
        XCTAssertEqual(sut.numberOfFields, 0)
    }
    
    func test_fetchFields_withValidFields_callsDidUpdate() {
        let field = SmartServiceField(
            fieldTypeID: 1,
            fieldName: "Test Field",
            iconName: "star.fill",
            serviceProvider: []
        )
        mockBookingService.mockFields = [field]
        
        sut.fetchFields()
        
        XCTAssertTrue(mockDelegate.didUpdateCalled)
        XCTAssertFalse(mockDelegate.didFailCalled)
        XCTAssertEqual(sut.numberOfFields, 1)
        XCTAssertEqual(sut.cellViewModel(for: 0)?.fieldName, "Test Field")
    }
    
    func test_cellViewModel_forInvalidIndex_returnsNil() {
        let cellVM = sut.cellViewModel(for: 5)
        XCTAssertNil(cellVM)
    }
    
    func test_serviceProviderViewModel_forInvalidIndex_returnsNil() {
        let spVM = sut.serviceProviderViewModel(for: 5)
        XCTAssertNil(spVM)
    }
}

final class MockFieldsBookingService: SmartBookingServiceProtocol {
    var mockFields: [SmartServiceField] = []
    
    func fetchFields(serviceID: Int, completion: @escaping ([SmartServiceField]?, Error?) -> Void) {
        completion(mockFields.isEmpty ? nil : mockFields, nil)
    }
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {}
    func fetchProviders(fieldTypeID: Int, completion: @escaping ([ServiceProvider]?, Error?) -> Void) {}
    func fetchAppointments(completion: @escaping ([Appointment]?, Error?) -> Void) {}
}

final class MockServiceFieldsDelegate: SmartServiceFieldsViewModelDelegate {
    var didUpdateCalled = false
    var didFailCalled = false
    
    func didUpdateFields() { didUpdateCalled = true }
    func didFailedWithError() { didFailCalled = true }
}
