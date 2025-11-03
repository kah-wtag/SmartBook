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
            guard let date = DateTimeHelper.date(
                from: appointment.date,
                format: DateFormat.yyyy_MM_dd_HH_mm_ss_Z
            ) else { return nil }
            return (date >= now && date <= sevenDaysFromNow) ? appointment : nil
        }
        .sorted { a1, a2 in
            guard let d1 = DateTimeHelper.date(
                from: a1.date ?? "",
                format: DateFormat.yyyy_MM_dd_HH_mm_ss_Z
            ),
                  let d2 = DateTimeHelper.date(
                    from: a2.date ?? "",
                    format: DateFormat.yyyy_MM_dd_HH_mm_ss_Z
                  ) else {
                return false
            }
            return d1 < d2
        }
    }
    
    var onDataUpdated: (() -> Void)?
    
    func loadAppointments() {
        SmartBookingAPIService.shared.fetchAppointments { [weak self] appointments, error in
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
    
#if DEBUG
    func setAppointmentsForTesting(_ appointments: [Appointment]?) {
        self.appointments = appointments ?? []
        self.onDataUpdated?()
    }
#endif
}
