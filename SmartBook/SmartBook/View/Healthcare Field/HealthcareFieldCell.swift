//
//  HealthcareFieldCell.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

class HealthcareFieldCell: UICollectionViewCell {
    @IBOutlet var healthcareFieldIcon: UIImageView!
    @IBOutlet var healthcareFieldName: UILabel!
    @IBOutlet var healthcareFieldDoctorsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 1
        healthcareFieldName.setFontSize(.large, weight: .semibold, dynamic: true)
        healthcareFieldDoctorsCount.setFontSize(.regular, weight: .regular, dynamic: false)
        setupTextColor()
    }
    
    private func setupTextColor() {
        layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
        layer.backgroundColor = UIColor(named: "textfieldColor")?.cgColor
        healthcareFieldIcon.tintColor = .secondaryText
        healthcareFieldName.textColor = .primaryText
        healthcareFieldDoctorsCount.textColor = .primaryText
    }
    
    func configure(with field: HealthcareFieldViewModel.HealthcareField) {
        healthcareFieldIcon.image = UIImage(systemName: field.iconName)
        healthcareFieldName.text = field.name
        healthcareFieldDoctorsCount.text = "\(field.doctorsCount) doctors available"
    }
}
