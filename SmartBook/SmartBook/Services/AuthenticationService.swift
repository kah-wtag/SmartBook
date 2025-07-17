//
//  AuthenticationService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/7/25.
//

import UIKit

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    private let userDefaultsKey = "registeredUsers"
    
    func signup(user: User) -> Bool {
        var users = fetchUsers()
        if users.contains(where: { $0.email == user.email }) {
            return false // Email already exists
        }
        users.append(user)
        saveUsers(users)
        return true
    }
    
    func login(email: String, password: String) -> Bool {
        let users = fetchUsers()
        return users.contains { $0.email == email && $0.password == password }
    }
    
    private func fetchUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }
    
    private func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
}

