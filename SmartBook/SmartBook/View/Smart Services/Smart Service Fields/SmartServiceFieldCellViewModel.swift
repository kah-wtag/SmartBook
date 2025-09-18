//
//  SmartServiceFieldCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/10/25.
//

import UIKit

final class SmartServiceFieldCellViewModel {

    var field: SmartServiceField
    
    init(field: SmartServiceField) {
        self.field = field
    }

    var fieldName: String {
        field.fieldName ?? "Unknown"
    }

    var icon: UIImage? {
        let iconName = field.iconName ?? "questionmark.circle"
        return UIImage(systemName: iconName)
    }

    var serviceProvidersCount: String {
        "\(field.serviceProviderCount) Service Providers"
    }
}
