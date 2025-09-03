//
//  UITextLabel+Extension.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 2/9/25.
//

import UIKit

extension UILabel {
    
    enum PaddingDirection {
        case top, left, bottom, right
    }
    
    func addPadding(_ directions: [PaddingDirection], value: CGFloat = 8) {
        let insets = UIEdgeInsets(
            top: directions.contains(.top) ? value : 0,
            left: directions.contains(.left) ? value : 0,
            bottom: directions.contains(.bottom) ? value : 0,
            right: directions.contains(.right) ? value : 0
        )
        
        let paddedLabel = UILabelPadding(padding: insets)
        paddedLabel.text = self.text
        paddedLabel.font = self.font
        paddedLabel.textColor = self.textColor
        paddedLabel.textAlignment = self.textAlignment
        paddedLabel.numberOfLines = self.numberOfLines
        paddedLabel.backgroundColor = self.backgroundColor
        
        self.superview?.addSubview(paddedLabel)
        self.removeFromSuperview()
    }
}

final class UILabelPadding: UILabel {
    var padding: UIEdgeInsets
    
    init(padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.padding = .zero
        super.init(coder: aDecoder)
    }
    
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
