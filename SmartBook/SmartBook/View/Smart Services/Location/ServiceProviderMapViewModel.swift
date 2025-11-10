//
//  ServiceProviderMapViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 27/10/25.
//

import Foundation
import MapKit

final class ServiceProviderMapViewModel {
    
    private let provider: ServiceProvider
    
    init(provider: ServiceProvider) {
        self.provider = provider
    }
    
    var name: String {
        provider.name ?? "Unknown Provider"
    }
    
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = provider.latitude,
              let lon = provider.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    var isLocationAvailable: Bool {
        coordinate != nil
    }

    var mapRegion: MKCoordinateRegion? {
        guard let coordinate = coordinate else { return nil }
        return MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
    }
    
    func annotation() -> MKPointAnnotation? {
        guard let coordinate = coordinate else { return nil }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        return annotation
    }
}
