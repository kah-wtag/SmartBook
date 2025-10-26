//
//  AppointmentCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import Foundation

final class AppointmentCellViewModel {
    
    private let appointment: Appointment
    
    init(appointment: Appointment) {
        self.appointment = appointment
    }
    
    var serviceProviderName: String {
        appointment.providerName ?? "Unknown"
    }
    
    var appointmentDateText: String {
        guard let dateStr = appointment.date,
              let date = DateFormatter.appointmentDateParser.date(from: dateStr) else { return "N/A" }
        return DateFormatter.displayFormatter.string(from: date)
    }
    
    var appointmentTimeText: String {
        appointment.time ?? "N/A"
    }
}
