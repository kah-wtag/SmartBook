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
    private var options: [String] = []
    private var radioButtonsIcon: [RadioIconView] = []
    private var preselectedOption: String?
    private var axis: NSLayoutConstraint.Axis?
    
    func configure(
        delegate: RadioButtonGroupViewDelegate?,
        options: [String],
        preselectedOption: String? = nil,
        axis: NSLayoutConstraint.Axis = .horizontal
    ) {
        self.delegate = delegate
        self.options = options
        self.preselectedOption = preselectedOption
        self.axis = axis
        
        let radioButtonStackView = UIStackView()
        radioButtonStackView.axis = axis
        radioButtonStackView.spacing = 30
        radioButtonStackView.alignment = .leading
        radioButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(radioButtonStackView)
        
        NSLayoutConstraint.activate([
            radioButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioButtonStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        for (index, title) in options.enumerated() {
            let radioButtonIcon = RadioIconView()
            radioButtonIcon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                radioButtonIcon.widthAnchor.constraint(equalToConstant: 20),
                radioButtonIcon.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            let radioButtonTitleLabel = UILabel()
            radioButtonTitleLabel.text = title
            radioButtonTitleLabel.setFontSize(.large)
            radioButtonTitleLabel.textColor = .primaryText
            
            let radioButtonRowStackView = UIStackView(arrangedSubviews: [radioButtonIcon, radioButtonTitleLabel])
            radioButtonRowStackView.axis = .horizontal
            radioButtonRowStackView.spacing = 6
            radioButtonRowStackView.alignment = .center
            radioButtonRowStackView.tag = index
            radioButtonRowStackView.isUserInteractionEnabled = true
            radioButtonRowStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped(_:))))
            
            radioButtonStackView.addArrangedSubview(radioButtonRowStackView)
            radioButtonsIcon.append(radioButtonIcon)
            
            if preselectedOption?.lowercased() == title.lowercased() {
                radioButtonIcon.isSelected = true
            }
        }
    }
    
    @objc private func radioButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        
        for (i, circle) in radioButtonsIcon.enumerated() {
            circle.isSelected = (i == index)
        }
        
        let selectedTitle = options[index]
        delegate?.radioButtonGroup(self, didSelect: selectedTitle)
    }
}
