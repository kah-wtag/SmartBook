//
//  UITextLabel+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 2/9/25.
//

import UIKit

final class UILabelPadding: UILabel {
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
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

extension UILabel {
    func setHorizontalPadding(_ padding: CGFloat = 10) {
        guard let text = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = padding
        paragraphStyle.headIndent = padding
        paragraphStyle.tailIndent = -padding

        let attributedString = NSAttributedString(
            string: text,
            attributes: [.paragraphStyle: paragraphStyle]
        )

        self.attributedText = attributedString
    }
}

