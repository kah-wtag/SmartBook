//
//  SmartServiceFieldsViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

protocol SmartServiceFieldsViewModelDelegate: AnyObject {
    func didUpdateFields()
    func didFailedWithError()
}

final class SmartServiceFieldsViewModel {
    
    private let service: SmartBookingServiceProtocol
    private let serviceID: Int
    private let serviceName: String
    private var fields: [SmartServiceField] = []
    
    var numberOfFields: Int { fields.count }
    var screenTitle: String { serviceName }
    
    weak var delegate: SmartServiceFieldsViewModelDelegate?
    
    init(service: SmartService, bookingService: SmartBookingServiceProtocol = SmartBookingService.shared) {
            self.serviceID = service.serviceID ?? 0
            self.serviceName = service.serviceName ?? "Service"
            self.service = bookingService
        }
    
    func cellViewModel(for index: Int) -> SmartServiceFieldCellViewModel? {
        guard index < fields.count else { return nil }
        return SmartServiceFieldCellViewModel(field: fields[index])
    }
    
    func fetchFields() {
        service.fetchFields(serviceID: serviceID) { [weak self] data, error in
            guard let self, let data else {
                self?.delegate?.didFailedWithError()
                return
            }
            self.fields = data
            self.delegate?.didUpdateFields()
        }
    }
    
    func serviceProviderViewModel(for index: Int) -> ServiceProviderViewModel? {
        guard index < fields.count else { return nil }
        return ServiceProviderViewModel(field: fields[index])
    }
}
