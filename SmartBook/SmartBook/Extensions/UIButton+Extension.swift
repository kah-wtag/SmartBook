//
//  UIButton+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/7/25.
//

import UIKit

extension UIButton {
    func applyButtonRoundBorder(borderColor: UIColor = .buttonBorder, borderWidth: CGFloat = 4, cornerRadius: CGFloat = 8) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}


