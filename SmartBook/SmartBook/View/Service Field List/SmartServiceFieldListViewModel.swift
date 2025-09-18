//
//  SmartServiceFieldListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//
import UIKit

protocol SmartServiceFieldListViewModelDelegate: AnyObject {
    func didUpdateFields()
}

final class SmartServiceFieldListViewModel {
    
    private var services: SmartService
    private(set) var fields: [SmartServiceField] = []
    weak var delegate: SmartServiceFieldListViewModelDelegate?
    
    var screenTitle: String {
        services.serviceName ?? "Service Fields"
    }
    
    init(service: SmartService) {
        self.services = service
        self.fields = service.fields ?? []
    }
    
    func numberOfFields() -> Int {
        fields.count
    }
    
    func field(at index: Int) -> SmartServiceField {
        fields[index]
    }
    
    func fetchFields() {
        AuthenticationService.shared.fetchSmartServices { [weak self] services in
            guard let self else { return }
            
            if let updatedService = services.first(where: { $0.serviceID == self.services.serviceID }) {
                self.services = updatedService
                self.fields = updatedService.fields ?? []
                
                DispatchQueue.main.async {
                    self.delegate?.didUpdateFields()
                }
            }
        }
    }
}
