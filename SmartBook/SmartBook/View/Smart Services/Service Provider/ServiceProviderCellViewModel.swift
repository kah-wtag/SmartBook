//
//  ServiceProviderCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/10/25.
//

import UIKit

final class ServiceProviderCellViewModel {

    var serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    var name: String {
        serviceProvider.name ?? "Unknown"
    }

    var experience: String {
        let years = serviceProvider.experience ?? 0
        return "\(years) yrs experience"
    }

    var image: UIImage? {
        guard let imageName = serviceProvider.imageName else { return nil }
        return UIImage(named: imageName)
    }
}
