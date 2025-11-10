//
//  RadioCircleView.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 9/10/25.
//

import UIKit

final class RadioIconView: UIView {
    
    var selectedColor: UIColor = .secondaryText {
        didSet { updateIcon() }
    }
    
    var unselectedColor: UIColor = .primaryText {
        didSet { updateIcon() }
    }
    
    var isSelected: Bool = false {
        didSet { updateIcon() }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        updateIcon()
    }
    
    private func updateIcon() {
        let radioButtonIconName = isSelected ? "inset.filled.circle" : "circle"
        imageView.image = UIImage(systemName: radioButtonIconName)
        imageView.tintColor = isSelected ? selectedColor : unselectedColor
    }
}
