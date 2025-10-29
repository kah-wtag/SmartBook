//
//  AppointmentCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import UIKit

final class AppointmentCellViewModel {
    
    private let appointment: Appointment
    
    init(appointment: Appointment) {
        self.appointment = appointment
    }
    
    var serviceProviderName: String {
        appointment.providerName ?? "Unknown"
    }
    
    var appointmentDateText: String {
        DateTimeHelper.convertToDate(
            dateString: appointment.date,
            from: DateFormat.appointmentAPI,
            to: DateFormat.dateOnly
        )
    }
    
    var appointmentTimeText: String {
        appointment.time ?? "N/A"
    }
}
