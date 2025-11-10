//
//  DateTimeHelper.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 29/10/25.
//

import UIKit

final class DateTimeHelper {
    
    static var cachedFormatters: [String: DateFormatter] = [:]
    
    static func formatter(for format: String) -> DateFormatter {
        if let cached = cachedFormatters[format] {
            return cached
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        formatter.timeZone = .current
        cachedFormatters[format] = formatter
        return formatter
    }
    
    static func convertToDate(
        dateString: String?,
        from fromFormat: String,
        to toFormat: String
    ) -> String {
        guard let dateString,
              let date = date(from: dateString, format: fromFormat) else { return "N/A" }
        return formatter(for: toFormat).string(from: date)
    }
    
    static func date(from dateString: String?, format: String) -> Date? {
        guard let dateString else { return nil }
        return formatter(for: format).date(from: dateString)
    }
}
