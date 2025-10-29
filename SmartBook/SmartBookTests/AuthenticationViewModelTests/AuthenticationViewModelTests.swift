//
//  AuthenticationViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/10/25.
//

import XCTest
@testable import SmartBook

final class AuthenticationViewModelTests: XCTestCase {
    var sut: AuthenticationViewModel!
    var mockDelegate: MockDelegate!
    var mockAuthService: MockAuthService!
    var mockBookingService: MockBookingService!
    
    override func setUp() {
        super.setUp()
        sut = AuthenticationViewModel()
        mockDelegate = MockDelegate()
        mockAuthService = MockAuthService()
        mockBookingService = MockBookingService()
    }
    
    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockBookingService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func test_loginSuccess_whenServiceIsNil() {
        sut = AuthenticationViewModel(authService: mockAuthService, bookingService: mockBookingService)
        sut.delegate = mockDelegate
        
        sut.loginButtonDidTap()
        
        XCTAssertTrue(mockDelegate.didShowLoader)
        XCTAssertNil(mockDelegate.fetchedServices)
    }
    
    func test_loginSuccess_forValidServices() {
        sut = AuthenticationViewModel(authService: mockAuthService, bookingService: mockBookingService)
        mockDelegate.fetchedServices = [SmartService(serviceID: 1, serviceName: "Test Service", fields: [])]
        sut.delegate = mockDelegate
        
        sut.loginButtonDidTap()
        
        XCTAssertTrue(mockDelegate.didShowLoader)
        XCTAssertEqual(mockDelegate.fetchedServices?.count, 1)
        XCTAssertEqual(mockDelegate.fetchedServices?.first?.serviceID, 1)
    }
}


final class MockAuthService: AuthenticationServiceProtocol {
    var shouldLoginSucceed = true
    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        completion(shouldLoginSucceed)
    }
}


final class MockBookingService: SmartBookingServiceProtocol {
    let mockServices = [SmartService(serviceID: 1, serviceName: "Test Service", fields: [])]
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {
        completion(mockServices, nil)
    }
    func fetchFields(serviceID: Int, completion: @escaping ([SmartServiceField]?, Error?) -> Void) {}
    func fetchProviders(fieldTypeID: Int, completion: @escaping ([ServiceProvider]?, Error?) -> Void) {}
    func fetchAppointments(completion: @escaping ([Appointment]?, Error?) -> Void) {}
}


final class MockDelegate: AuthenticationViewModelDelegate {
    var didShowLoader = false
    var didHideLoader = false
    var fetchedServices: [SmartService]?
    
    func showLoader() { didShowLoader = true }
    func hideLoader() { didHideLoader = true }
    func didFetchServices(_ services: [SmartService]) { fetchedServices = services }
}
