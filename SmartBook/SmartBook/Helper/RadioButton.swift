//
//  RadioButton.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 9/10/25.
//

import UIKit

class RadioButton: UIButton {

    private let dotView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    private func setupAppearance() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.primaryReverseText.cgColor
        self.clipsToBounds = true

        dotView.backgroundColor = UIColor.systemTeal
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.isHidden = true
        self.addSubview(dotView)

        NSLayoutConstraint.activate([
            dotView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dotView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dotView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            dotView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        dotView.layer.cornerRadius = dotView.bounds.height / 2
    }

    override var isSelected: Bool {
        didSet {
            dotView.isHidden = !isSelected
            self.layer.borderColor = isSelected ? UIColor.systemTeal.cgColor : UIColor.lightGray.cgColor
        }
    }
}
