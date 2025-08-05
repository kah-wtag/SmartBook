//
//  UIImageView+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

extension UIImageView {
    func makeCircular(withRadius radius: CGFloat? = nil) {
        let appliedRadius = radius ?? (self.frame.height / 2)
        self.layer.cornerRadius = appliedRadius
        self.layer.masksToBounds = true
    }
}


