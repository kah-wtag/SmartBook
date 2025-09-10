//
//  UIFont+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

extension UIFont {
    enum TextSize: Int {
        case title = 27
        case large = 17
        case regular = 14
        case small = 12
    }
    
    static func textSize(ofSize size: TextSize, weight: UIFont.Weight = .regular, fontName: String? = "Helvetica Neue") -> UIFont {
        UIFont.systemFont(ofSize: CGFloat(size.rawValue), weight: weight)
    }
}

