//
//  SmartServiceFieldListCell.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServiceFieldListCell: UICollectionViewCell {
    @IBOutlet var smartServiceFieldListIcon: UIImageView!
    @IBOutlet var smartServiceFieldListName: UILabel!
    @IBOutlet var smartServiceFieldListProfessionalsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 3
        smartServiceFieldListName.setFontSize(.large, weight: .semibold, dynamic: true)
        smartServiceFieldListProfessionalsCount.setFontSize(.regular, weight: .regular, dynamic: false)
        setupTextColor()
    }
    
    private func setupTextColor() {
        smartServiceFieldListIcon.tintColor = .secondaryText
        smartServiceFieldListName.textColor = .primaryText
        smartServiceFieldListProfessionalsCount.textColor = .primaryText
        layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
        layer.backgroundColor = UIColor(named: "textfieldColor")?.cgColor
    }
    
    func configure(with field: SmartServiceField) {
        let iconName = field.iconName ?? "questionmark.circle"
        smartServiceFieldListIcon.image = UIImage(systemName: iconName)
        smartServiceFieldListName.text = field.fieldName ?? "Unknown"
        let count = field.professionalsCount ?? 0
        smartServiceFieldListProfessionalsCount.text = "\(count) Professionals Available"
    }
}
