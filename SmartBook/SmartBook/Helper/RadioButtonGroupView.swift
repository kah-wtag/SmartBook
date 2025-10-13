//
//  RadioButtonGroupView.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/10/25.
//

import UIKit

protocol RadioButtonGroupViewDelegate: AnyObject {
    func radioButtonGroup(_ group: RadioButtonGroupView, didSelect option: String)
}

final class RadioButtonGroupView: UIView {
    
    weak var delegate: RadioButtonGroupViewDelegate?
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
            circle.isUserInteractionEnabled = true
            let circleTap = UITapGestureRecognizer(target: self, action: #selector(circleTapped(_:)))
            circle.addGestureRecognizer(circleTap)
            circle.tag = index
            
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.setFontSize(.regular, weight: .medium)
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
        let selectedOption = buttons[sender.tag].title(for: .normal) ?? ""
        delegate?.radioButtonGroup(self, didSelect: selectedOption)
    }
    
    @objc private func circleTapped(_ sender: UITapGestureRecognizer) {
        guard let circle = sender.view else { return }
        selectIndex(circle.tag)
    }
    
    private func selectIndex(_ index: Int) {
        for (i, circle) in circles.enumerated() {
            circle.isSelected = (i == index)
        }
        let selectedOption = buttons[index].title(for: .normal) ?? ""
        delegate?.radioButtonGroup(self, didSelect: selectedOption)
    }
}
