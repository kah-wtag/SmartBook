//
//  NameValidation.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 16/10/25.
//

import Foundation

extension String {

    func isValidName(minLength: Int = 3, maxLength: Int = 25) -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        guard trimmed.count >= minLength && trimmed.count <= maxLength else { return false }
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        return trimmed.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }
}
