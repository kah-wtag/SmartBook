//
//  NotificationCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 27/10/25.
//

import UIKit

final class NotificationCellViewModel {
    
    private let appointment: Appointment
    
    init(appointment: Appointment) {
        self.appointment = appointment
    }
    
    var dateText: String {
        guard let dateStr = appointment.date,
              let date = DateFormatter.appointmentDateParser.date(
                from: dateStr
              ) else {
            return "N/A"
        }
        return DateFormatter.displayFormatter.string(from: date)
    }
    
    var serviceProviderName: String {
        appointment.providerName ?? "Unknown"
    }
    
    var timeText: String {
        appointment.time ?? "N/A"
    }
}
