//
//  UIView+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 24/7/25.
//

import UIKit

extension UIView {
    func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: bounds.height - width, width: bounds.width, height: width)
        layer.addSublayer(border)
    }
}

extension UIColor {
    static var buttonBorderColor: UIColor {
        return UIColor(named: "buttonBorderColor") ?? .gray
    }
}

extension UIColor {
    static var textColor: UIColor {
        return UIColor(named: "primaryTextColor") ?? .gray
    }
}
