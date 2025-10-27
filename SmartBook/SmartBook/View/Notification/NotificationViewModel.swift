//
//  NotificationViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 27/10/25.
//

import UIKit

final class NotificationViewModel {
    
    private var appointments: [Appointment] = []
    
    var upcomingAppointments: [Appointment] {
        let now = Date()
        let sevenDaysFromNow = Calendar.current.date(
            byAdding: .day, value: 7, to: now
        ) ?? now
        
        return appointments.compactMap { appointment in
            guard let dateStr = appointment.date,
                  let date = DateFormatter.appointmentDateParser.date(
                    from: dateStr
                  ) else {
                return nil
            }
            return (
                date >= now && date <= sevenDaysFromNow
            ) ? appointment : nil
        }
        .sorted { a1, a2 in
            guard let d1 = DateFormatter.appointmentDateParser.date(from: a1.date ?? ""),
                  let d2 = DateFormatter.appointmentDateParser.date(
                    from: a2.date ?? ""
                  ) else {
                return false
            }
            return d1 < d2
        }
    }
    
    var onDataUpdated: (() -> Void)?
    
    func loadAppointments() {
        SmartBookingService.shared.fetchAppointments { [weak self] appointments, error in
            guard let self else { return }
            
            if let appointments {
                self.appointments = appointments
                DispatchQueue.main.async {
                    self.onDataUpdated?()
                }
            } else if let error {
                print("Failed to fetch notifications:", error)
            }
        }
    }
    
    var numberOfNotifications: Int {
        upcomingAppointments.count
    }
    
    func notificationCellViewModel(at index: Int) -> NotificationCellViewModel? {
        guard upcomingAppointments.indices.contains(index) else { return nil }
        return NotificationCellViewModel(appointment: upcomingAppointments[index])
    }
}
