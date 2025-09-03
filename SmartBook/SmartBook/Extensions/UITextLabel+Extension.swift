//
//  UITextLabel+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 2/9/25.
//

import UIKit

final class UILabelPadding: UILabel {
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
    }
}
