//
//  UIButton+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/7/25.
//

import UIKit

extension UIButton {
    enum TextSize : Int {
        case extraLarge = 19, regular = 15, small = 12
    }
    
    func setFontSize(_ size: TextSize, weight: UIFont.Weight = .regular) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size.rawValue), weight: weight)
    }
    
    func applyButtonRoundBorder(borderColor: UIColor = .border, borderWidth: CGFloat = 4, cornerRadius: CGFloat = 8) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}


