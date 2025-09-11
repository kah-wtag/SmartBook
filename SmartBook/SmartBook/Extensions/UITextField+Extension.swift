//
//  UITextField+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 24/7/25.
//

import UIKit

extension UITextField {
    enum PaddingDirection {
        case left, right
    }
    
    func verticalPadding(_ directions: [PaddingDirection], width: CGFloat = 20) {
        for direction in directions {
            let paddingView: UIView
            switch direction {
            case .left:
                paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
                leftView = paddingView
                leftViewMode = .always
            case .right:
                paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
                rightView = paddingView
                rightViewMode = .always
            }
        }
    }
    
    func horizontalPadding(_ padding: CGFloat = 0) {
        let leadingPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        let trailingPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        
        leftView = leadingPaddingView
        leftViewMode = .always
        rightView = trailingPaddingView
        rightViewMode = .always
    }
    
    func setStyledPlaceholder(
        _ text: String,
        color: UIColor = .placeholder,
        size: UIFont.TextSize = .regular
    ) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: color,
                .font: UIFont.textSize(ofSize: size)
            ]
        )
    }
    
    func applyStyle(fontSize: UIFont.TextSize = .regular,
                    textColor: UIColor = .primaryText,
                    backgroundColor: UIColor = .textfield,
                    cornerRadius: CGFloat = 10,
                    borderColor: UIColor = .clear,
                    borderWidth: CGFloat = 0,
                    horizontalPadding: CGFloat = 10) {
        
        font = .textSize(ofSize: fontSize)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
        self.horizontalPadding(horizontalPadding)
    }
    
    func textFieldStyle() {
        applyStyle(
            fontSize: .regular,
            textColor: .primaryText,
            backgroundColor: .secondaryBackground,
            cornerRadius: 10,
            borderColor: .textfield,
            borderWidth: 1,
            horizontalPadding: 12
        )
    }
}


