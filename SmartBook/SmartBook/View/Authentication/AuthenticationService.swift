//
//  AuthenticationService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/10/25.
//

import UIKit

final class AuthenticationService {

    static let shared = AuthenticationService()
    private init() { }

    func login(username: String? = nil, password: String? = nil, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(true)
        }
    }
}
