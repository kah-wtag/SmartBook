//
//  ServiceListService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/9/25.
//

import Foundation

final class ServiceListService {
    func fetchServices(completion: @escaping ([String]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let mockServices = [
                "Healthcare",
                "Education & Tutoring",
                "Home Services",
                "Business & Admin",
                "Personal Care"
            ]
            completion(mockServices)
        }
    }
}
