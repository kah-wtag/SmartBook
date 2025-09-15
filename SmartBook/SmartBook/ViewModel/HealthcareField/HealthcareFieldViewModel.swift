//
//  Untitled.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

final class HealthcareFieldViewModel {
    
    struct HealthcareField {
        let name: String
        let iconName: String
        let doctorsCount: Int
    }
    
    private let fields = [
        HealthcareField(name: "Dentist", iconName: "heart.fill", doctorsCount: 12),
        HealthcareField(name: "Cardiology", iconName: "heart.fill", doctorsCount: 8),
        HealthcareField(name: "Dermatology", iconName: "bandage.fill", doctorsCount: 6),
        HealthcareField(name: "Neurology", iconName: "brain.head.profile", doctorsCount: 4),
        HealthcareField(name: "Pediatrics", iconName: "stethoscope", doctorsCount: 10)
    ]
    
    func numberOfFields() -> Int {
        fields.count
    }
    
    func field(at index: Int) -> HealthcareField {
        fields[index]
    }
}
