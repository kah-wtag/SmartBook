//
//  Validation+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 23/10/25.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: trimmed)
    }
    
    func isValidName(minLength: Int = 3, maxLength: Int = 25) -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              trimmed.count >= minLength,
              trimmed.count <= maxLength else { return false }
        
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        return trimmed.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }
    
    func isValidPhone() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        
        let internationalPhoneNumberRegex = #"^\+?[1-9]\d{0,3}[-.\s]?\d{1,14}$"#
        return NSPredicate(format: "SELF MATCHES %@", internationalPhoneNumberRegex).evaluate(with: trimmed)
    }
}
