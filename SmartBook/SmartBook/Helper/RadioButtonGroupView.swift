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
    private var circles: [RadioCircleView] = []
    
    func configure(
        options: [String],
        preselectedOption: String? = nil,
        selectedColor: UIColor = .secondaryText,
        unselectedColor: UIColor = .primaryText
    ) {
        subviews.forEach { $0.removeFromSuperview() }
        circles.removeAll()
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
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
            NSLayoutConstraint.activate([
                circle.widthAnchor.constraint(equalToConstant: 20),
                circle.heightAnchor.constraint(equalToConstant: 20)
            ])
            circle.tag = index
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = .label
            label.isUserInteractionEnabled = false 
            
            let horizontal = UIStackView(arrangedSubviews: [circle, label])
            horizontal.axis = .horizontal
            horizontal.spacing = 5
            horizontal.alignment = .center
            horizontal.distribution = .fill
            horizontal.tag = index
            horizontal.isUserInteractionEnabled = true
            horizontal.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:))))
            
            stack.addArrangedSubview(horizontal)
            circles.append(circle)
            
            if let preselected = preselectedOption,
               preselected.lowercased() == title.lowercased() {
                circle.isSelected = true
                delegate?.radioButtonGroup(self, didSelect: title)
            }
        }
    }
    
    @objc private func optionTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        selectIndex(tappedView.tag)
    }
    
    private func selectIndex(_ index: Int) {
        for (i, circle) in circles.enumerated() {
            circle.isSelected = (i == index)
        }
        let selectedTitle = (subviews.first as? UIStackView)?
            .arrangedSubviews[index]
            .subviews
            .compactMap { $0 as? UILabel }
            .first?
            .text ?? ""
        delegate?.radioButtonGroup(self, didSelect: selectedTitle)
    }
}
