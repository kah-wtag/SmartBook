//
//  ServiceListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class ServiceListViewModel {
    
    private let service = ServiceListService()
    private(set) var services: [String] = []
    
    var onDataUpdated: (() -> Void)?
    
    func fetchServices() {
        service.fetchServices { [weak self] data in
            DispatchQueue.main.async {
                self?.services = data
                self?.onDataUpdated?()
            }
        }
    }
    
    func numberOfServices() -> Int {
        services.count
    }
    
    func serviceName(at index: Int) -> String {
        services[index]
    }
    
    func didSelectService(at index: Int, navigationController: UINavigationController?) {
        guard index < services.count else { return }
        
        if index == 0 {
            Routes.displayHealthcareField(from: navigationController)
        } else {
            let serviceName = services[index]
            print("Service clicked: \(serviceName)")
        }
    }
}
