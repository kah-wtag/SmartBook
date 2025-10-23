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
    private var redioButtonsCircle: [RadioCircleView] = []
    
    func configure(
        options: [String],
        preselectedOption: String? = nil,
        axis: NSLayoutConstraint.Axis = .horizontal
    ) {
        clearExistingButtons()
        
        let radioButtonStackView = createMainStackView(axis: axis)
        addSubview(radioButtonStackView)
        constrainToEdges(radioButtonStackView)
        
        for (index, title) in options.enumerated() {
            let radioButtonIcon = createRadioCircle(selectedColor: .secondaryText, unselectedColor: .primaryText)
            let radioButtonLabel = createRadioButtonTitle(title: title, color: .primaryText)
            
            let radioButtonRowStack = createRadioButtonStackView(views: [radioButtonIcon, radioButtonLabel], tag: index)
            addTapRecognizer(to: radioButtonRowStack)
            
            radioButtonStackView.addArrangedSubview(radioButtonRowStack)
            redioButtonsCircle.append(radioButtonIcon)
            
            if let preselectedRadioButton = preselectedOption,
               preselectedRadioButton.lowercased() == title.lowercased() {
                radioButtonIcon.isSelected = true
            }
        }
    }
    
    private func clearExistingButtons() {
        subviews.forEach { $0.removeFromSuperview() }
        redioButtonsCircle.removeAll()
    }
    
    private func createMainStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let radioButtonStack = UIStackView()
        radioButtonStack.axis = axis
        radioButtonStack.spacing = axis == .horizontal ? 10 : 8
        radioButtonStack.alignment = .center
        radioButtonStack.distribution = .fill
        radioButtonStack.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonStack
    }
    
    private func constrainToEdges(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createRadioCircle(selectedColor: UIColor, unselectedColor: UIColor) -> RadioCircleView {
        let radioButtonIcon = RadioCircleView()
        radioButtonIcon.selectedColor = selectedColor
        radioButtonIcon.unselectedColor = unselectedColor
        radioButtonIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButtonIcon.widthAnchor.constraint(equalToConstant: 20),
            radioButtonIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        return radioButtonIcon
    }
    
    private func createRadioButtonTitle(title: String, color: UIColor) -> UILabel {
        let radioButtonTitle = UILabel()
        radioButtonTitle.text = title
        radioButtonTitle.setFontSize(.regular)
        radioButtonTitle.textColor = .primaryText
        return radioButtonTitle
    }
    
    private func createRadioButtonStackView(views: [UIView], tag: Int) -> UIStackView {
        let radioButtonsStackView = UIStackView(arrangedSubviews: views)
        radioButtonsStackView.axis = .horizontal
        radioButtonsStackView.spacing = 5
        radioButtonsStackView.alignment = .center
        radioButtonsStackView.distribution = .fill
        radioButtonsStackView.tag = tag
        radioButtonsStackView.isUserInteractionEnabled = true
        return radioButtonsStackView
    }
    
    private func addTapRecognizer(to view: UIView) {
        let radioButtonTap = UITapGestureRecognizer(target: self, action: #selector(radioButtonDidTap(_:)))
        view.addGestureRecognizer(radioButtonTap)
    }
    
    @objc private func radioButtonDidTap(_ sender: UITapGestureRecognizer) {
        guard let radioButtonTappedView = sender.view else { return }
        selectIndex(radioButtonTappedView.tag)
    }
    
    private func selectIndex(_ index: Int) {
        for (i, radioButtonIcon) in redioButtonsCircle.enumerated() {
            radioButtonIcon.isSelected = (i == index)
        }
        if let radioButtonHorizontalStack = redioButtonsCircle[index].superview as? UIStackView,
           let radioButtonsTitle = radioButtonHorizontalStack.arrangedSubviews[1] as? UILabel {
            delegate?.radioButtonGroup(self, didSelect: radioButtonsTitle.text ?? "")
        }
    }
}
