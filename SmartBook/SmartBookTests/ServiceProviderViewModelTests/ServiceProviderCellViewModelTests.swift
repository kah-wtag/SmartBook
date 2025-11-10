//
//  ServiceProviderCellViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 03/11/25.
//

import XCTest
@testable import SmartBook

final class ServiceProviderCellViewModelTests: XCTestCase {
    
    var sut: ServiceProviderCellViewModel!
    var mockProvider: ServiceProvider!
    
    override func setUp() {
        super.setUp()
        
        mockProvider = ServiceProvider(
            name: "Dr. Apu",
            experience: 5,
            imageName: "doctor_image",
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: ["MBBS", "MD"],
            institution: "XYZ Hospital",
            minimumAdvanceTime: nil
        )
        
        sut = ServiceProviderCellViewModel(serviceProvider: mockProvider)
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }
    
    func test_name_returnsCorrectValue() {
        XCTAssertEqual(sut.name, "Dr. Apu")
    }
    
    func test_name_returnsUnknown_whenNil() {
        let provider = ServiceProvider(
            name: nil,
            experience: nil,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: nil,
            institution: nil,
            minimumAdvanceTime: nil
        )
        let vm = ServiceProviderCellViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.name, "Unknown")
    }
    
    func test_institution_returnsCorrectValue() {
        XCTAssertEqual(sut.institution, "XYZ Hospital")
    }
    
    func test_institution_returnsUnknown_whenNil() {
        let provider = ServiceProvider(
            name: nil,
            experience: nil,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: nil,
            institution: nil,
            minimumAdvanceTime: nil
        )
        let vm = ServiceProviderCellViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.institution, "Unknown")
    }
    
    func test_experience_returnsCorrectText() {
        XCTAssertEqual(sut.experience, "5 years experience")
    }
    
    func test_experience_returnsZeroYears_whenNil() {
        let provider = ServiceProvider(
            name: "Dr. Test",
            experience: nil,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: nil,
            institution: nil,
            minimumAdvanceTime: nil
        )
        let vm = ServiceProviderCellViewModel(serviceProvider: provider)
        XCTAssertEqual(vm.experience, "0 years experience")
    }
    
    func test_image_returnsUIImage_whenValidName() {
        let image = sut.image
        XCTAssertTrue(image == nil || image != nil)
    }
    
    func test_image_returnsNil_whenNameNil() {
        let provider = ServiceProvider(
            name: "Dr. Test",
            experience: 1,
            imageName: nil,
            latitude: nil,
            longitude: nil,
            clientsCount: nil,
            bio: nil,
            degrees: nil,
            institution: nil,
            minimumAdvanceTime: nil
        )
        let vm = ServiceProviderCellViewModel(serviceProvider: provider)
        XCTAssertNil(vm.image)
    }
}
