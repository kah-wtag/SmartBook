//
//  SmartServiceFieldCell.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServiceFieldCell: UICollectionViewCell {
    @IBOutlet var smartServiceFieldIcon: UIImageView!
    @IBOutlet var smartServiceFieldName: UILabel!
    @IBOutlet var smartServiceFieldServiceProviderCount: UILabel!
    
    var viewModel: SmartServiceFieldCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 3
        smartServiceFieldName.setFontSize(.large, weight: .semibold, dynamic: true)
        smartServiceFieldServiceProviderCount.setFontSize(.regular, weight: .regular, dynamic: false)
        setupTextColor()
    }
    
    private func setupTextColor() {
        smartServiceFieldIcon.tintColor = .secondaryText
        smartServiceFieldName.textColor = .primaryText
        smartServiceFieldServiceProviderCount.textColor = .primaryText
        layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
        layer.backgroundColor = UIColor(named: "textfieldColor")?.cgColor
    }
    
    func updateUI() {
        guard let viewModel else { return }
        smartServiceFieldName.text = viewModel.fieldName
        smartServiceFieldIcon.image = viewModel.icon
        smartServiceFieldServiceProviderCount.text = viewModel.serviceProvidersCount
    }
}
