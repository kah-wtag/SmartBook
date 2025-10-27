//
//  UIButton+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/7/25.
//

import UIKit

extension UIButton {
    func setFontSize(_ size: UIFont.TextSize, weight: UIFont.Weight = .regular, dynamic: Bool = true) {
        titleLabel?.font = UIFont.of(size: size, weight: weight, dynamic: dynamic)
        titleLabel?.adjustsFontForContentSizeCategory = dynamic
    }

    func applyRoundBorder(color: UIColor = .border, width: CGFloat = 2, radius: CGFloat = 8) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
