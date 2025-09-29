//
//  AuthenticationService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/9/25.
//

import UIKit

final class AuthenticationService {
    
    static let shared = AuthenticationService()
    private init() { }
    private let smartServicesURLString = "https://smartbooking111.free.beeceptor.com/data"
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(true)
        }
    }
    
    func fetchSmartServices(completion: @escaping ([SmartService]) -> Void) {
        guard let url = URL(string: smartServicesURLString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                return completion([])
            }
            
            do {
                let response = try JSONDecoder().decode(SmartServiceList.self, from: data)
                completion(response.services ?? [])
            } catch {
                print("JSON decode error:", error)
                completion([])
            }
        }.resume()
    }
}
