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
    
    func addPadding(_ directions: [PaddingDirection], width: CGFloat = 8) {
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
    
    func setStyledPlaceholder(_ text: String, color: UIColor = .lightGray) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color]
        )
    }
    
    func applyUnderline(color: UIColor = .lightGray, thickness: CGFloat = 0.5, padding: CGFloat = 3) {
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


