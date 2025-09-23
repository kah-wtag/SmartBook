//
//  HealthcareFieldViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import Foundation

final class HealthcareFieldViewModel {
    
    private let service = HealthcareFieldService()
    private(set) var fields: [HealthcareField] = []
    
    var onDataUpdated: (() -> Void)?
    
    func fetchFields() {
        service.fetchHealthcareFields { [weak self] data in
            DispatchQueue.main.async {
                self?.fields = data
                self?.onDataUpdated?()
            }
        }
    }
    
    func numberOfFields() -> Int {
        fields.count
    }
    
    func field(at index: Int) -> HealthcareField {
        fields[index]
    }
}
