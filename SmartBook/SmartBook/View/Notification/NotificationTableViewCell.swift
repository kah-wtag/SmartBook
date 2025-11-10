//
//  NotificationTableViewCell.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 4/9/25.
//

import UIKit

final class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet var notificationTextLabel: UILabel!
    @IBOutlet var isReadImageView: UIImageView!
    
    var viewModel: NotificationCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        notificationTextLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        notificationTextLabel.textColor = .primaryText
    }
    
    func updateUI() {
        guard let viewModel else { return }
        notificationTextLabel.attributedText = viewModel.notificationMessage
        isReadImageView.isHidden = !(viewModel.showUnreadIcon)
        selectionStyle = .none
        separatorInset = .zero
    }
}
