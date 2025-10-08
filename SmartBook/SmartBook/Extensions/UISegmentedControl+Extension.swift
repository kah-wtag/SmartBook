//
//  UISegmentedControl+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 14/9/25.
//

import UIKit

extension UISegmentedControl {
    func setFontSize(_ size: UIFont.TextSize,
                     weight: UIFont.Weight = .bold,
                     dynamic: Bool = true,
                     color: UIColor = .primaryReverseText) {
        
        let font = UIFont.of(size: size, weight: weight, dynamic: dynamic)
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        setTitleTextAttributes(attributes, for: .normal)
        setTitleTextAttributes(attributes, for: .selected)
        
        guard dynamic else { return }
        NotificationCenter.default.addObserver(
            forName: UIContentSizeCategory.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            let updatedFont = UIFont.of(size: size, weight: weight, dynamic: true)
            let updatedAttributes: [NSAttributedString.Key: Any] = [.font: updatedFont, .foregroundColor: color]
            self.setTitleTextAttributes(updatedAttributes, for: .normal)
            self.setTitleTextAttributes(updatedAttributes, for: .selected)
        }
    }
}
