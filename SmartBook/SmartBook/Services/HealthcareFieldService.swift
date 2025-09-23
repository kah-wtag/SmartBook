//
//  HealthcareFieldService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/9/25.
//

import Foundation

final class HealthcareFieldService {
    
    func fetchHealthcareFields(completion: @escaping ([HealthcareField]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let mockData = [
                HealthcareField(name: "Dentist", iconName: "heart.fill", doctorsCount: 12),
                HealthcareField(name: "Cardiology", iconName: "heart.fill", doctorsCount: 8),
                HealthcareField(name: "Dermatology", iconName: "bandage.fill", doctorsCount: 6),
                HealthcareField(name: "Neurology", iconName: "brain.head.profile", doctorsCount: 4),
                HealthcareField(name: "Pediatrics", iconName: "stethoscope", doctorsCount: 10)
            ]
            completion(mockData)
        }
    }
}
