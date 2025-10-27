//
//  ServiceProviderProfileViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 29/9/25.
//

import UIKit

final class ServiceProviderProfileViewModel {
    
    private var serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    var provider: ServiceProvider {
        return serviceProvider
    }
    
    var minimumAdvanceTime: TimeInterval {
        serviceProvider.minimumAdvanceTime ?? 0
    }
    var nameText: String {
        serviceProvider.name ?? "Unknown"
    }
    var experienceText: String {
        "\(serviceProvider.experience ?? 0) Years+"
    }
    var fieldText: String {
        serviceProvider.bio ?? "-"
    }
    var image: UIImage? {
        guard let name = serviceProvider.imageName else {
            return UIImage(systemName: "person.circle")
        }
        return UIImage(named: name)
    }
    var patientCountText: String {
        "\(serviceProvider.clientsCount ?? 0)+ Patients"
    }
    var degreesText: String {
        serviceProvider.degrees?.joined(separator: ", ") ?? "-"
    }
    var institutionText: String {
        serviceProvider.institution ?? "-"
    }
    var bioText: String {
        serviceProvider.bio ?? "-"
    }
}
