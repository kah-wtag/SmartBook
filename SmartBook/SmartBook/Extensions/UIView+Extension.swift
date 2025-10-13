//
//  UIView+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/10/25.
//

import UIKit

extension UIView {
    func applyBorderRound(
        color: UIColor = .border,
        width: CGFloat = 2,
        radius: CGFloat = 8
    ) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
