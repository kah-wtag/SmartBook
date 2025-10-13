//
//  RadioButtonGroupView.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/10/25.
//

import UIKit

final class RadioButtonGroupView: UIView {
    
    private var buttons: [UIButton] = []
    private var circles: [RadioCircleView] = []
    
    var selectedIndex: Int? = nil
    var onSelectionChanged: ((String) -> Void)?
    
    func configure(options: [String], selectedColor: UIColor = .secondaryText, unselectedColor: UIColor = .primaryText) {
        subviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        circles.removeAll()
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        for (index, title) in options.enumerated() {
            let circle = RadioCircleView()
            circle.selectedColor = selectedColor
            circle.unselectedColor = unselectedColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                circle.widthAnchor.constraint(equalToConstant: 20),
                circle.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            button.tintColor = .label
            button.tag = index
            button.contentHorizontalAlignment = .leading
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            
            let horizontal = UIStackView(arrangedSubviews: [circle, button])
            horizontal.axis = .horizontal
            horizontal.spacing = 5
            horizontal.alignment = .center
            horizontal.distribution = .fill
            
            stack.addArrangedSubview(horizontal)
            
            buttons.append(button)
            circles.append(circle)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        for (index, circle) in circles.enumerated() {
            circle.isSelected = (index == sender.tag)
        }
        selectedIndex = sender.tag
        onSelectionChanged?(buttons[sender.tag].title(for: .normal) ?? "")
    }
}
