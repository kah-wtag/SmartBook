//
//  AppointmentCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import Foundation

final class AppointmentCellViewModel {
    
    private let appointment: Appointment
    private let dateFormatter: DateFormatter
    private let isoFormatter: ISO8601DateFormatter
    
    init(appointment: Appointment,
         dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, h:mm a"
        return formatter
    }(),
         isoFormatter: ISO8601DateFormatter = ISO8601DateFormatter()) {
        self.appointment = appointment
        self.dateFormatter = dateFormatter
        self.isoFormatter = isoFormatter
    }
    
    var providerName: String {
        appointment.providerName ?? "Unknown"
    }
    
    var dateText: String {
        guard let isoString = appointment.date,
              let date = isoFormatter.date(from: isoString) else {
            return "N/A"
        }
        return dateFormatter.string(from: date)
    }
    
    var timeText: String {
        appointment.time ?? "N/A"
    }
}
