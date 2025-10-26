//
//  AppointmentCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 26/10/25.
//

import Foundation

struct AppointmentCellViewModel {
    let dateText: String
    let providerName: String
    let timeText: String

    init(appointment: Appointment, dateFormatter: DateFormatter, isoFormatter: ISO8601DateFormatter) {
        if let dateString = appointment.date, let date = isoFormatter.date(from: dateString) {
            dateText = dateFormatter.string(from: date)
        } else {
            dateText = "N/A"
        }
        providerName = appointment.providerName ?? "-"
        timeText = appointment.time ?? "-"
    }
}
