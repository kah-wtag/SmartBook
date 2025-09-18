//
//  ServiceListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class ServiceListViewModel {
    
    private let services = [
        "Healthcare",
        "Education & Tutoring",
        "Home Services",
        "Business & Admin",
        "Personal Care"
    ]
    
    func numberOfServices() -> Int {
        services.count
    }
    
    func serviceName(at index: Int) -> String {
        services[index]
    }
}
