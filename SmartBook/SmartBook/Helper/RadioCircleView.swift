//
//  RadioCircleView.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 9/10/25.
//

import UIKit

final class RadioCircleView: UIView {
    
    var selectedColor: UIColor = .secondaryText {
        didSet { updateDotLayer() }
    }
    
    var unselectedColor: UIColor = .primaryText {
        didSet { layer.borderColor = unselectedColor.cgColor }
    }
    
    private let dotLayer = CAShapeLayer()
    
    var isSelected: Bool = false {
        didSet { updateDotLayer() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 2
        layer.borderColor = unselectedColor.cgColor
        clipsToBounds = true
        
        dotLayer.fillColor = selectedColor.cgColor
        layer.addSublayer(dotLayer)
    }
    
    private func updateDotLayer() {
        dotLayer.fillColor = isSelected ? selectedColor.cgColor : UIColor.clear.cgColor
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        
        let dotRadius = bounds.width * 0.25
        let dotRect = CGRect(
            x: bounds.midX - dotRadius,
            y: bounds.midY - dotRadius,
            width: dotRadius * 2,
            height: dotRadius * 2
        )
        let path = UIBezierPath(ovalIn: dotRect)
        dotLayer.path = path.cgPath
    }
}
