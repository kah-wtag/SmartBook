//
//  EmailValidation.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 16/10/25.
//

import UIKit

struct EmailValidation {
    static func isValid(_ email: String) -> Bool {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.contains(" ") else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: trimmed)
    }
}
