//
//  UITextField+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 24/7/25.
//

import UIKit

extension UITextField {
    func setFontSize(_ size: UIFont.TextSize, weight: UIFont.Weight = .regular, dynamic: Bool = true) {
        font = UIFont.of(size: size, weight: weight, dynamic: dynamic)
        adjustsFontForContentSizeCategory = dynamic
    }
    
    func setStyledPlaceholder(_ text: String,
                              color: UIColor = .placeholder,
                              size: UIFont.TextSize? = nil,
                              weight: UIFont.Weight = .regular,
                              dynamic: Bool = true) {
        let placeholderFont = size.map { UIFont.of(size: $0, weight: weight, dynamic: dynamic) } ?? font ?? UIFont.of(size: .regular)
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color, .font: placeholderFont]
        )
    }
    
    func horizontalPadding(_ padding: CGFloat = 10) {
        let left = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        let right = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        leftView = left; leftViewMode = .always
        rightView = right; rightViewMode = .always
    }
    
    enum PaddingDirection {
        case left, right
    }
    
    func verticalPadding(_ directions: [PaddingDirection], width: CGFloat = 10) {
        for direction in directions {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
            switch direction {
            case .left:
                leftView = paddingView
                leftViewMode = .always
            case .right:
                rightView = paddingView
                rightViewMode = .always
            }
        }
    }
    
    func textFieldStyle(dynamic: Bool = true) {
        setFontSize(.regular, dynamic: dynamic)
        textColor = .primaryText
        backgroundColor = .secondaryBackground
        layer.cornerRadius = 10
        layer.borderColor = UIColor.textfield.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        horizontalPadding(12)
    }
}
