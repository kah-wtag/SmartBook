//
//  ServiceProviderMapViewModelTests.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/11/25.
//

import XCTest
import MapKit
@testable import SmartBook

final class ServiceProviderMapViewModelTests: XCTestCase {
    
    func testNameReturnsProviderNameOrDefault() {
        let providerWithName = ServiceProvider(
            name: "Provider A", latitude: 23.8103, longitude: 90.4125
        )
        let vmWithName = ServiceProviderMapViewModel(provider: providerWithName)
        XCTAssertEqual(vmWithName.name, "Provider A")
        
        let providerWithoutName = ServiceProvider(
            name: nil, latitude: 23.8103, longitude: 90.4125
        )
        let vmWithoutName = ServiceProviderMapViewModel(provider: providerWithoutName)
        XCTAssertEqual(vmWithoutName.name, "Unknown Provider")
    }
    
    func testCoordinateReturnsNilIfNoLatLon() {
        let providerWithCoordinates = ServiceProvider(
            name: "Provider A", latitude: 23.8103, longitude: 90.4125
        )
        let vmWithCoordinates = ServiceProviderMapViewModel(provider: providerWithCoordinates)
        XCTAssertNotNil(vmWithCoordinates.coordinate)
        XCTAssertEqual(vmWithCoordinates.coordinate?.latitude, 23.8103)
        XCTAssertEqual(vmWithCoordinates.coordinate?.longitude, 90.4125)
        
        let providerWithoutCoordinates = ServiceProvider(
            name: "Provider B", latitude: nil, longitude: nil
        )
        let vmWithoutCoordinates = ServiceProviderMapViewModel(provider: providerWithoutCoordinates)
        XCTAssertNil(vmWithoutCoordinates.coordinate)
    }
    
    func testIsLocationAvailable() {
        let provider = ServiceProvider(
            name: "Provider A", latitude: 23.8103, longitude: 90.4125
        )
        let vm = ServiceProviderMapViewModel(provider: provider)
        XCTAssertTrue(vm.isLocationAvailable)
        
        let providerNoLocation = ServiceProvider(
            name: "Provider B", latitude: nil, longitude: nil
        )
        let vmNoLocation = ServiceProviderMapViewModel(provider: providerNoLocation)
        XCTAssertFalse(vmNoLocation.isLocationAvailable)
    }
    
    func testMapRegionReturnsCorrectRegionOrNil() {
        let provider = ServiceProvider(
            name: "Provider A", latitude: 23.8103, longitude: 90.4125
        )
        let vm = ServiceProviderMapViewModel(provider: provider)
        XCTAssertNotNil(vm.mapRegion)
        XCTAssertEqual(vm.mapRegion?.center.latitude, 23.8103)
        XCTAssertEqual(vm.mapRegion?.center.longitude, 90.4125)
        
        let providerNoLocation = ServiceProvider(
            name: "Provider B", latitude: nil, longitude: nil
        )
        let vmNoLocation = ServiceProviderMapViewModel(provider: providerNoLocation)
        XCTAssertNil(vmNoLocation.mapRegion)
    }
    
    func testAnnotationReturnsMKPointAnnotationOrNil() {
        let provider = ServiceProvider(
            name: "Provider A", latitude: 23.8103, longitude: 90.4125
        )
        let vm = ServiceProviderMapViewModel(provider: provider)
        let annotation = vm.annotation()
        XCTAssertNotNil(annotation)
        XCTAssertEqual(annotation?.coordinate.latitude, 23.8103)
        XCTAssertEqual(annotation?.coordinate.longitude, 90.4125)
        
        let providerNoLocation = ServiceProvider(
            name: "Provider B", latitude: nil, longitude: nil
        )
        let vmNoLocation = ServiceProviderMapViewModel(provider: providerNoLocation)
        XCTAssertNil(vmNoLocation.annotation())
    }
}
