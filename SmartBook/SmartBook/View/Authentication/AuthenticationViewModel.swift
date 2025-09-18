//
//  AuthenticationViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/9/25.
//

import Foundation

protocol AuthenticationViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func didFetchServices(_ services: [SmartService])
}

final class AuthenticationViewModel {
    
    private let service = AuthenticationService.shared
    weak var delegate: AuthenticationViewModelDelegate?
    
    func loginButtonDidTap() {
        delegate?.showLoader()
        performLogin()
    }
    
    private func performLogin() {
        service.login(username: "", password: "") { _ in
            self.fetchServices()
        }
    }
    
    private func fetchServices() {
        service.fetchSmartServices { services in
            DispatchQueue.main.async {
                self.delegate?.hideLoader()
                self.delegate?.didFetchServices(services)
            }
        }
    }
}
