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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
