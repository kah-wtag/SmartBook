//
//  PhoneValidation.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 16/10/25.
//

import Foundation

struct PhoneValidation {
    static func isValid(_ phone: String) -> Bool {
        let trimmed = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { return false }
        let internationalPhoneNumberRegex = #"^\+?[1-9]\d{0,3}[-.\s]?\d{1,14}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", internationalPhoneNumberRegex)
        return predicate.evaluate(with: trimmed)
    }
}
