//
//  AppointmentListTableViewCell.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 26/8/25.
//

import UIKit

class AppointmentListTableViewCell: UITableViewCell {
    @IBOutlet var appointmentListDate: UILabel!
    @IBOutlet var appointmentListProfessionalsName: UILabel!
    @IBOutlet var appointmentListTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        appointmentListDate.setFontSize(.regular, weight: .bold)
        appointmentListProfessionalsName.setFontSize(.regular, weight: .regular)
        appointmentListTime.setFontSize(.regular, weight: .bold)
        setupTextColor()
    }
    
    private func setupTextColor() {
        appointmentListDate.textColor = .primaryText
        appointmentListProfessionalsName.textColor = .primaryText
        appointmentListTime.textColor = .primaryText
    }
    
    func configure(with viewModel: AppointmentCellViewModel) {
        appointmentListDate.text = viewModel.dateText
        appointmentListProfessionalsName.text = viewModel.providerName
        appointmentListTime.text = viewModel.timeText
        selectionStyle = .none
        separatorInset = .zero
    }
}
