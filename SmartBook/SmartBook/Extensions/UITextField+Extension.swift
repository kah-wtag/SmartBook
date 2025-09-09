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
    
    func setHorizontalPadding(_ padding: CGFloat = 0) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        
        leftView = leftPaddingView
        leftViewMode = .always
        rightView = rightPaddingView
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

    func applyUnderline(
        leftPadding: CGFloat = 0,
        rightPadding: CGFloat = 0,
        color: UIColor = .placeholder,
        thickness: CGFloat = 1.0
    ) {
        let underline = UIView()
        underline.tag = 999
        underline.backgroundColor = color 
        underline.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underline)
        
        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: thickness),
            underline.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding),
            underline.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightPadding),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}


