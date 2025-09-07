//
//  UIButton+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/7/25.
//

import UIKit

extension UIButton {
    func setFontSize(_ size: UIFont.TextSize, weight: UIFont.Weight = .regular) {
        self.titleLabel?.font = UIFont.textSize(ofSize: size, weight: weight)
    }
    
    func applyButtonRoundBorder(borderColor: UIColor = .border, borderWidth: CGFloat = 4, cornerRadius: CGFloat = 8) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
