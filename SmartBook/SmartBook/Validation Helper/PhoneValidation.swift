//
//  PhoneValidation.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 16/10/25.
//

import UIKit

struct PhoneValidation {
    static func isValid(_ phone: String, maxLength: Int = 15) -> Bool {
        let trimmed = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.count <= maxLength else { return false }
        let phoneRegex = "^[0-9]{1,\(maxLength)}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: trimmed)
    }
}
