//
//  SmartServiceFieldCellViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 03/11/25.
//

import XCTest
@testable import SmartBook

final class SmartServiceFieldCellViewModelTests: XCTestCase {
    
    var sut: SmartServiceFieldCellViewModel!
    var mockField: SmartServiceField!
    
    override func setUp() {
        super.setUp()
        
        let mockProvider = ServiceProvider(
            name: "Provider1",
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
        
        mockField = SmartServiceField(
            fieldTypeID: 1,
            fieldName: "Test Field",
            iconName: "star.fill",
            serviceProvider: [mockProvider]
        )
        
        sut = SmartServiceFieldCellViewModel(field: mockField)
    }

    
    override func tearDown() {
        sut = nil
        mockField = nil
        super.tearDown()
    }
    
    func test_fieldName_returnsCorrectValue() {
        XCTAssertEqual(sut.fieldName, "Test Field")
    }
    
    func test_fieldName_returnsUnknown_whenNil() {
        let field = SmartServiceField(fieldTypeID: 1, fieldName: nil, iconName: nil, serviceProvider: nil)
        let vm = SmartServiceFieldCellViewModel(field: field)
        XCTAssertEqual(vm.fieldName, "Unknown")
    }
    
    func test_icon_returnsUIImage_forValidIconName() {
        XCTAssertNotNil(sut.icon)
    }
    
    func test_icon_returnsDefault_whenIconNameNil() {
        let field = SmartServiceField(fieldTypeID: 1, fieldName: "Field", iconName: nil, serviceProvider: nil)
        let vm = SmartServiceFieldCellViewModel(field: field)
        XCTAssertNotNil(vm.icon) 
    }
    
    func test_serviceProvidersCount_returnsCorrectCount() {
        XCTAssertEqual(sut.serviceProvidersCount, "1 Service Providers")
    }
    
    func test_serviceProvidersCount_returnsZero_whenNil() {
        let field = SmartServiceField(fieldTypeID: 1, fieldName: "Field", iconName: nil, serviceProvider: nil)
        let vm = SmartServiceFieldCellViewModel(field: field)
        XCTAssertEqual(vm.serviceProvidersCount, "0 Service Providers")
    }
}
