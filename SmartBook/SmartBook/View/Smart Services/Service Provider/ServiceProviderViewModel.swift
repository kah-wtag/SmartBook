//
//  ServiceProviderViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 29/9/25.
//

import UIKit

protocol ServiceProviderViewModelDelegate: AnyObject {
    func didUpdateProfessionals()
    func didFailedWithError()
}

final class ServiceProviderViewModel {
    
    private var field: SmartServiceField
    private var serviceProviders: [ServiceProvider] = []
    weak var delegate: ServiceProviderViewModelDelegate?
    
    var numberOfServiceProvider: Int { return serviceProviders.count }
    var screenTitle: String {
        field.fieldName ?? "Professionals"
    }
    
    init(field: SmartServiceField) {
        self.field = field
        self.serviceProviders = field.serviceProvider ?? []
    }
    
    func providerCellViewModel(at index: Int) -> ServiceProviderCellViewModel {
        ServiceProviderCellViewModel(serviceProvider: serviceProviders[index])
    }
    
    func fetchServiceProviders() {
        guard let fieldTypeID = field.fieldTypeID else { return }
        
        SmartBookingService.shared.fetchProviders(fieldTypeID: fieldTypeID) { [weak self] providers, _ in
            guard let self, let providers else {
                self?.delegate?.didFailedWithError()
                return
            }
            self.serviceProviders = providers
            DispatchQueue.main.async {
                self.delegate?.didUpdateProfessionals()
            }
        }
    }
    
    func serviceProviderProfileViewModel(for index: Int) -> ServiceProviderProfileViewModel? {
        guard index < serviceProviders.count else { return nil }
        return ServiceProviderProfileViewModel(serviceProvider: serviceProviders[index])
    }
}
