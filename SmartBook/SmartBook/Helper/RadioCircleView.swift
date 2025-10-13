//
//  RadioCircleView.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 9/10/25.
//

import UIKit

final class RadioCircleView: UIView {
    
    var selectedColor: UIColor = .secondaryText {
        didSet { dotView.backgroundColor = selectedColor }
    }
    
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
        clipsToBounds = true
        
        dotView.backgroundColor = selectedColor
        dotView.isHidden = true
        addSubview(dotView)
        dotView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dotView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            dotView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            dotView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        dotView.layer.cornerRadius = dotView.bounds.width / 2
    }
}
