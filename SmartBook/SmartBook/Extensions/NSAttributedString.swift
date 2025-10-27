//
//  NSAttributedString.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 29/10/25.
//

import UIKit

extension NSAttributedString {
    static func fromHTML(_ html: String, fontSize: CGFloat = 14) -> NSAttributedString {
        guard let data = html.data(using: .utf16) else {
            return NSAttributedString(string: html)
        }
        do {
            let attributed = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf16.rawValue
                ],
                documentAttributes: nil
            )

            attributed.enumerateAttribute(.font, in: NSRange(location: 0, length: attributed.length), options: []) { value, range, _ in
                if let currentFont = value as? UIFont {
                    let newFont = UIFont(descriptor: currentFont.fontDescriptor, size: fontSize)
                    attributed.addAttribute(.font, value: newFont, range: range)
                }
            }

            return attributed
        } catch {
            return NSAttributedString(string: html)
        }
    }
}
