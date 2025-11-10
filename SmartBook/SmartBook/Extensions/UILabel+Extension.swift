//
//  UILabel+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 2/9/25.
//

import UIKit

extension UILabel {
    func setFontSize(_ size: UIFont.TextSize, weight: UIFont.Weight = .regular, dynamic: Bool = true) {
        font = UIFont.of(size: size, weight: weight, dynamic: dynamic)
        adjustsFontForContentSizeCategory = dynamic
    }
    
    func horizontalPadding(_ padding: CGFloat = 10) {
        guard let text else { return }
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = padding
        style.headIndent = padding
        style.tailIndent = -padding
        attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle: style])
    }
    
    func applyRoundBorder(color: UIColor = .border, width: CGFloat = 2, radius: CGFloat = 8) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
