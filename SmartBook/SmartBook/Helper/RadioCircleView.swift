//
//  RadioButton.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 9/10/25.
//

import UIKit

class RadioCircleView: UIView {
    var selectedColor: UIColor = .secondaryText
    var unselectedColor: UIColor = .primaryText {
        didSet { layer.borderColor = unselectedColor.cgColor }
    }

    private let dotView = UIView()

    var isSelected: Bool = false {
        didSet { dotView.isHidden = !isSelected }
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
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true

        dotView.backgroundColor = selectedColor
        dotView.isHidden = true
        dotView.frame = CGRect(x: bounds.width*0.25, y: bounds.height*0.25, width: bounds.width*0.5, height: bounds.height*0.5)
        dotView.layer.cornerRadius = dotView.bounds.height/2
        addSubview(dotView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        let dotSize = bounds.width * 0.5
        dotView.frame = CGRect(
            x: (bounds.width - dotSize)/2,
            y: (bounds.height - dotSize)/2,
            width: dotSize,
            height: dotSize
        )
        dotView.layer.cornerRadius = dotSize / 2
    }
}
