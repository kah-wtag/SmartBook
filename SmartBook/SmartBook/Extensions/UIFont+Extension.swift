//
//  UIFont+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

extension UIFont {
    enum TextSize: CGFloat {
        case title = 27, large = 17, regular = 14, small = 12
    }

    static func of(size: TextSize, weight: UIFont.Weight = .regular, dynamic: Bool = true) -> UIFont {
        let font = UIFont.systemFont(ofSize: size.rawValue, weight: weight)
        return dynamic ? UIFontMetrics(forTextStyle: .body).scaledFont(for: font) : font
    }
}
