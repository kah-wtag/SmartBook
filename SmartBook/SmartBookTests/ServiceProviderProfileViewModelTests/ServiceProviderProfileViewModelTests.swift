//
//  ServiceProviderProfileViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 03/11/25.
//

import XCTest
@testable import SmartBook

final class ServiceProviderProfileViewModelTests: XCTestCase {
    
    var sut: ServiceProviderProfileViewModel!
    var mockProvider: ServiceProvider!
    
    override func setUp() {
        super.setUp()
        
        mockProvider = ServiceProvider(
            name: "Dr. John",
            experience: 10,
            imageName: "doctor_image",
            latitude: nil,
            longitude: nil,
            clientsCount: 50,
            bio: "Cardiologist",
            degrees: ["MBBS", "MD"],
            institution: "City Hospital",
            minimumAdvanceTime: 3600
        )
        
        sut = ServiceProviderProfileViewModel(serviceProvider: mockProvider)
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }
    
    func test_nameText_returnsCorrectValue() {
        XCTAssertEqual(sut.nameText, "Dr. John")
    }
    
    func test_nameText_returnsUnknown_whenNil() {
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.nameText, "Unknown")
    }
    
    func test_experienceText_returnsCorrectFormat() {
        XCTAssertEqual(sut.experienceText, "10 Years+")
    }
    
    func test_fieldText_returnsBio_orDash() {
        XCTAssertEqual(sut.fieldText, "Cardiologist")
        
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.fieldText, "-")
    }
    
    func test_patientCountText_returnsCorrectValue() {
        XCTAssertEqual(sut.patientCountText, "50+ Patients")
    }
    
    func test_degreesText_returnsJoinedDegrees_orDash() {
        XCTAssertEqual(sut.degreesText, "MBBS, MD")
        
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.degreesText, "-")
    }
    
    func test_institutionText_returnsCorrectValue_orDash() {
        XCTAssertEqual(sut.institutionText, "City Hospital")
        
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.institutionText, "-")
    }
    
    func test_bioText_returnsBio_orDash() {
        XCTAssertEqual(sut.bioText, "Cardiologist")
        
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.bioText, "-")
    }
    
    func test_minimumAdvanceTime_returnsCorrectValue_orZero() {
        XCTAssertEqual(sut.minimumAdvanceTime, 3600)
        
        let provider = ServiceProvider(name: nil, experience: nil, imageName: nil, latitude: nil, longitude: nil, clientsCount: nil, bio: nil, degrees: nil, institution: nil, minimumAdvanceTime: nil)
        let vm = ServiceProviderProfileViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.minimumAdvanceTime, 0)
    }
    
    func test_locationUnavailableAlert_returnsUIAlertController() {
        let alert = sut.locationUnavailableAlert
        XCTAssertEqual(alert.title, "Location Not Available")
        XCTAssertEqual(alert.message, "This service provider has no location information.")
        XCTAssertEqual(alert.actions.count, 1)
        XCTAssertEqual(alert.actions.first?.title, "OK")
    }
}
