//
//  ServiceProviderCell.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/8/25.
//

import UIKit

final class ServiceProviderCell: UITableViewCell {
    
    @IBOutlet var serviceProviderImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var institutionLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    @IBOutlet var bookButton: UIButton!
    @IBOutlet var mapButton: UIButton!
    
    var viewModel: ServiceProviderCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        nameLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        institutionLabel.setFontSize(.small, weight: .regular, dynamic: true)
        experienceLabel.setFontSize(.small, weight: .regular, dynamic: true)
        bookButton.setFontSize(.regular, weight: .medium, dynamic: true)
        mapButton.setFontSize(.regular, weight: .medium, dynamic: true)
        serviceProviderImageView.makeCircular()
        setupTextColor()
    }
    
    func setupTextColor() {
        nameLabel.textColor = .primaryText
        institutionLabel.textColor = .primaryText
        experienceLabel.textColor = .primaryText
        bookButton.titleLabel?.textColor = .secondaryText
        mapButton.titleLabel?.textColor = .secondaryText
    }
    
    func updateUI() {
        guard let viewModel else { return }
        nameLabel.text = viewModel.name
        institutionLabel.text = viewModel.institution
        experienceLabel.text = viewModel.experience
        serviceProviderImageView.image = viewModel.image
    }
}
