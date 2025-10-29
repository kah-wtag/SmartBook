//
//  AppointmentListTableViewCell.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 26/8/25.
//

import UIKit

final class AppointmentListTableViewCell: UITableViewCell {
    
    @IBOutlet var appointmentDateLabel: UILabel!
    @IBOutlet var serviceProvidersNameLabel: UILabel!
    @IBOutlet var appointmentTimeLabel: UILabel!
    
    var viewModel: AppointmentCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        appointmentDateLabel.setFontSize(.regular, weight: .bold)
        serviceProvidersNameLabel.setFontSize(.regular, weight: .regular)
        appointmentTimeLabel.setFontSize(.regular, weight: .bold)
        setupTextColor()
    }
    
    private func setupTextColor() {
        appointmentDateLabel.textColor = .primaryText
        serviceProvidersNameLabel.textColor = .primaryText
        appointmentTimeLabel.textColor = .primaryText
    }
    
    func updateUI() {
        guard let viewModel else { return }
        appointmentDateLabel.text = viewModel.appointmentDateText
        serviceProvidersNameLabel.text = viewModel.serviceProviderName
        appointmentTimeLabel.text = viewModel.appointmentTimeText
        selectionStyle = .none
        separatorInset = .zero
    }
}
