//
//  NameValidation.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 16/10/25.
//

import UIKit

struct NameValidation {
    static func isValid(_ name: String, maxLength: Int = 25) -> Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.count <= maxLength else { return false }
        return true
    }
}
