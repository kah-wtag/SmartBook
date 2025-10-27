//
//  NotificationTableViewCell.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 4/9/25.
//

import UIKit

final class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet var notificationDate: UILabel!
    @IBOutlet var notificationProfessionalsName: UILabel!
    @IBOutlet var noitficationTime: UILabel!
    
    var viewModel: NotificationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        notificationDate.setFontSize(.regular, weight: .bold, dynamic: true)
        notificationProfessionalsName.setFontSize(.regular, weight: .regular, dynamic: true)
        noitficationTime.setFontSize(.regular, weight: .bold, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        notificationDate.textColor = .primaryText
        notificationProfessionalsName.textColor = .primaryText
        noitficationTime.textColor = .primaryText
    }
    
    func updateUI() {
        guard let viewModel else { return }
        notificationDate.text = viewModel.dateText
        notificationProfessionalsName.text = viewModel.serviceProviderName
        noitficationTime.text = viewModel.timeText
        selectionStyle = .none
        separatorInset = .zero
    }
}
