//
//  UIFont+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

extension UIFont {
    enum TextSize: Int {
        case extraLarge = 19, regular = 15, small = 12
    }
    
    static func textSize(ofSize size: TextSize, weight: UIFont.Weight = .regular, customFontName: String? = nil) -> UIFont {
        if let customFont = UIFont(name: "Helvetica Neue", size: CGFloat(size.rawValue)) {
            return customFont
        }
        return UIFont.systemFont(ofSize: CGFloat(size.rawValue), weight: weight)
    }
}

