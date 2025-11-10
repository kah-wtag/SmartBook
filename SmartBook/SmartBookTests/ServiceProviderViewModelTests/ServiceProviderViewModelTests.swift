//
//  ServiceProviderViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 03/11/25.
//

import XCTest
@testable import SmartBook

final class ServiceProviderViewModelTests: XCTestCase {

    var sut: ServiceProviderViewModel!
    var mockField: SmartServiceField!
    var mockDelegate: MockServiceProviderDelegate!
    var mockBookingService: MockServiceProviderService!

    override func setUp() {
        super.setUp()
        
        let provider1 = ServiceProvider(
            name: "Dr. John",
            experience: 10,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: 50,
            bio: "Cardiologist",
            degrees: ["MBBS", "MD"],
            institution: "City Hospital",
            minimumAdvanceTime: 3600
        )
        
        mockField = SmartServiceField(
            fieldTypeID: 1,
            fieldName: "Cardiology",
            iconName: nil,
            serviceProvider: [provider1]
        )
        
        mockDelegate = MockServiceProviderDelegate()
        mockBookingService = MockServiceProviderService()
        
        sut = ServiceProviderViewModel(field: mockField, bookingService: mockBookingService)
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        sut = nil
        mockField = nil
        mockDelegate = nil
        mockBookingService = nil
        super.tearDown()
    }

    func test_numberOfServiceProvider_returnsCorrectCount() {
        XCTAssertEqual(sut.numberOfServiceProvider, 1)
    }

    func test_screenTitle_returnsFieldName() {
        XCTAssertEqual(sut.screenTitle, "Cardiology")
    }

    func test_providerCellViewModel_returnsCorrectViewModel() {
        let cellVM = sut.providerCellViewModel(at: 0)
        XCTAssertEqual(cellVM.serviceProvider.name, "Dr. John")
    }

    func test_serviceProviderProfileViewModel_returnsCorrectViewModel() {
        let profileVM = sut.serviceProviderProfileViewModel(for: 0)
        XCTAssertNotNil(profileVM)
        XCTAssertEqual(profileVM?.nameText, "Dr. John")
    }

    func test_serviceProviderProfileViewModel_returnsNilForInvalidIndex() {
        let profileVM = sut.serviceProviderProfileViewModel(for: 5)
        XCTAssertNil(profileVM)
    }

    func test_fetchServiceProviders_callsDelegateDidUpdate_onSuccess() {
        let provider2 = ServiceProvider(
            name: "Dr. Jane",
            experience: 5,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: nil,
            institution: nil,
            minimumAdvanceTime: nil
        )
        mockBookingService.mockProviders = [provider2]
        
        let expectation = self.expectation(description: "Delegate called")
        mockDelegate.expectation = expectation
        
        sut.fetchServiceProviders()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockDelegate.didUpdateCalled)
        XCTAssertFalse(mockDelegate.didFailCalled)
    }

    func test_fetchServiceProviders_callsDelegateDidFail_onFailure() {
        mockBookingService.mockProviders = nil
        
        let expectation = self.expectation(description: "Delegate called")
        mockDelegate.expectation = expectation
        
        sut.fetchServiceProviders()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(mockDelegate.didUpdateCalled)
        XCTAssertTrue(mockDelegate.didFailCalled)
    }

    func test_fetchServiceProviders_doesNothing_ifFieldTypeIDNil() {
        mockField = SmartServiceField(fieldTypeID: nil, fieldName: "Empty", iconName: nil, serviceProvider: nil)
        sut = ServiceProviderViewModel(field: mockField, bookingService: mockBookingService)
        sut.delegate = mockDelegate
        
        sut.fetchServiceProviders()
        
        XCTAssertFalse(mockDelegate.didUpdateCalled)
        XCTAssertFalse(mockDelegate.didFailCalled)
    }
}

final class MockServiceProviderDelegate: ServiceProviderViewModelDelegate {
    var didUpdateCalled = false
    var didFailCalled = false
    var expectation: XCTestExpectation?
    
    func didUpdateProfessionals() {
        didUpdateCalled = true
        expectation?.fulfill()
    }
    
    func didFailedWithError() {
        didFailCalled = true
        expectation?.fulfill()
    }
}

final class MockServiceProviderService: SmartBookingServiceProtocol {
    
    var mockProviders: [ServiceProvider]? = []
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {}
    func fetchFields(serviceID: Int, completion: @escaping ([SmartServiceField]?, Error?) -> Void) {}
    
    func fetchProviders(fieldTypeID: Int, completion: @escaping ([ServiceProvider]?, Error?) -> Void) {
        completion(mockProviders, nil)
    }
    
    func fetchAppointments(completion: @escaping ([Appointment]?, Error?) -> Void) {}
}
