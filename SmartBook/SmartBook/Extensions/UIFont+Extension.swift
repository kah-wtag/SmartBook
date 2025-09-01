//
//  UIFont+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

extension UIFont {
    
    enum AppTextSize {
        case extraLarge, large, medium, small, extraSmall
    }
    
    static func textSize(ofSize size: AppTextSize, weight: UIFont.Weight = .regular) -> UIFont {
        let pointSize: CGFloat
        
        switch size {
        case .extraLarge: pointSize = 24
        case .large:      pointSize = 21
        case .medium:     pointSize = 18
        case .small:      pointSize = 15
        case .extraSmall: pointSize = 12
        }
        
        return UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
}


extension UIColor {
    static var buttonBorderColor: UIColor {
        UIColor(named: "buttonBorderColor") ?? .gray
    }
}

extension UIColor {
    static var textColor: UIColor {
        UIColor(named: "primaryTextColor") ?? .gray
    }
}

extension UIColor {
    static var secondaryTextColor: UIColor {
        UIColor(named: "secondaryTextColor") ?? .gray
    }
}
