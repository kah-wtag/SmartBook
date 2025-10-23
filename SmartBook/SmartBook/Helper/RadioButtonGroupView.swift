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
        
        let radioButtonsStackView = UIStackView()
        radioButtonsStackView.axis = .horizontal
        radioButtonsStackView.spacing = 10
        radioButtonsStackView.alignment = .center
        radioButtonsStackView.distribution = .fill
        addSubview(radioButtonsStackView)
        radioButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButtonsStackView.topAnchor.constraint(equalTo: topAnchor),
            radioButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            radioButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            radioButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        for (index, title) in options.enumerated() {
            let radioButtonIcon = RadioCircleView()
            radioButtonIcon.selectedColor = selectedColor
            radioButtonIcon.unselectedColor = unselectedColor
            radioButtonIcon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                radioButtonIcon.widthAnchor.constraint(equalToConstant: 20),
                radioButtonIcon.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            let radioButtonTitle = UILabel()
            radioButtonTitle.text = title
            radioButtonTitle.font = .systemFont(ofSize: 16, weight: .medium)
            radioButtonTitle.textColor = unselectedColor
            
            let horizontalRadioButtonStackView = UIStackView(arrangedSubviews: [radioButtonIcon, radioButtonTitle])
            horizontalRadioButtonStackView.axis = .horizontal
            horizontalRadioButtonStackView.spacing = 5
            horizontalRadioButtonStackView.alignment = .center
            horizontalRadioButtonStackView.distribution = .fill
            horizontalRadioButtonStackView.tag = index
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(radioButtonDidTap(_:)))
            horizontalRadioButtonStackView.isUserInteractionEnabled = true
            horizontalRadioButtonStackView.addGestureRecognizer(tap)
            
            radioButtonsStackView.addArrangedSubview(horizontalRadioButtonStackView)
            
            circles.append(radioButtonIcon)
            
            if let preselected = preselectedOption,
               preselected.lowercased() == title.lowercased() {
                radioButtonIcon.isSelected = true
            }
        }
    }
    
    @objc private func radioButtonDidTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        selectIndex(tappedView.tag)
    }
    
    private func selectIndex(_ index: Int) {
        for (i, circle) in circles.enumerated() {
            circle.isSelected = (i == index)
        }
        if let horizontalStack = circles[index].superview as? UIStackView,
           let label = horizontalStack.arrangedSubviews[1] as? UILabel {
            delegate?.radioButtonGroup(self, didSelect: label.text ?? "")
        }
    }
}
