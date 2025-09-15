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
            layer.cornerRadius = 15
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor
        }
    
    func configure(with field: HealthcareFieldViewModel.HealthcareField) {
        healthcareFieldIcon.image = UIImage(systemName: field.iconName)
        healthcareFieldName.text = field.name
        healthcareFieldDoctorsCount.text = "\(field.doctorsCount) doctors available"
        
    }
}
