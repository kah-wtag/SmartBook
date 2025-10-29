//
//  AuthenticationViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/9/25.
//

import UIKit

protocol AuthenticationViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func didFetchServices(_ services: [SmartService])
}

final class AuthenticationViewModel {
    
    private let authService = AuthenticationService.shared
    private let bookingService = SmartBookingAPIService.shared
    weak var delegate: AuthenticationViewModelDelegate?
    
    func loginButtonDidTap(username: String? = nil, password: String? = nil) {
        delegate?.showLoader()
        
        authService.login(username: username, password: password) { [weak self] success in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handleLoginResult(success)
            }
        }
    }
    
    private func handleLoginResult(_ success: Bool) {
        success ? fetchServicesDirectly() : delegate?.hideLoader()
    }
    
    private func fetchServicesDirectly() {
        bookingService.fetchServices { [weak self] services, error in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.delegate?.hideLoader()
                self.delegate?.didFetchServices(services ?? [])
            }
        }
    }
}
