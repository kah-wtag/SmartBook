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
    
    func addPadding(_ directions: [PaddingDirection], width: CGFloat = 20) {
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
    
    func setHorizontalPadding(_ padding: CGFloat = 10) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        
        leftView = leftPaddingView
        leftViewMode = .always
        rightView = rightPaddingView
        rightViewMode = .always
    }
    
    func setStyledPlaceholder(_ text: String, color: UIColor = .textfield) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color]
        )
    }
    
    func applyUnderline(color: UIColor = .textfield, thickness: CGFloat = 0.5, padding: CGFloat = 3) {
        layer.sublayers?.removeAll(where: { $0.name == "underlineLayer" })
        
        let border = CALayer()
        border.name = "underlineLayer"
        border.backgroundColor = color.cgColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height + padding,
            width: self.frame.size.width,
            height: thickness
        )
        layer.addSublayer(border)
    }
    
}


