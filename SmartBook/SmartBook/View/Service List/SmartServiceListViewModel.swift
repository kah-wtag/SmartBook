//
//  SmartServiceListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

protocol SmartServiceListViewModelDelegate: AnyObject {
    func didUpdateServices()
}

final class SmartServiceListViewModel {
    
    private let service = AuthenticationService.shared
    private(set) var services: [SmartService] = []
    
    weak var delegate: SmartServiceListViewModelDelegate?
    
    func fetchServices() {
        service.fetchSmartServices { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                self.services = data
                self.delegate?.didUpdateServices()
            }
        }
    }
    
    func numberOfServices() -> Int {
        services.count
    }
    
    func serviceName(at index: Int) -> String {
        guard index < services.count else { return "Unknown" }
        return services[index].serviceName ?? "Unknown"
    }
    
    func didSelectService(at index: Int, navigationController: UINavigationController?) {
        guard index < services.count else { return }
        let service = services[index]
        let fieldVC = Routes.smartServiceFieldVC
        fieldVC.viewModel = SmartServiceFieldListViewModel(service: service)
        navigationController?.pushViewController(fieldVC, animated: true)
    }
}
