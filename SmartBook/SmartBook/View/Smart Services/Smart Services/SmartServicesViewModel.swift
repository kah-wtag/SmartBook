//
//  SmartServicesViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

protocol SmartServicesViewModelDelegate: AnyObject {
    func didUpdateServices()
    func didFailedWithError()
}

final class SmartServicesViewModel {
    
    private let service: SmartBookingServiceProtocol
    private var services: [SmartService] = []
    
    weak var delegate: SmartServicesViewModelDelegate?
    
    var numberOfServices: Int { services.count }
    
    init(service: SmartBookingServiceProtocol = SmartBookingService.shared) {
        self.service = service
    }
    
    func fetchServices() {
        service.fetchServices { [weak self] newServices, error in
            guard let self, let newServices else {
                self?.delegate?.didFailedWithError()
                return
            }
            self.services = newServices
            self.delegate?.didUpdateServices()
        }
    }
    
    func serviceName(at index: Int) -> String {
        guard index < services.count else { return "Unknown" }
        return services[index].serviceName ?? "Unknown"
    }
    
    func serviceFieldsViewModel(for index: Int) -> SmartServiceFieldsViewModel? {
        guard index < services.count else { return nil }
        return SmartServiceFieldsViewModel(service: services[index])
    }
}
