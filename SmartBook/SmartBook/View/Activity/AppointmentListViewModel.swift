//
//  AppointmentListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import Foundation

final class AppointmentListViewModel {
    
    private(set) var appointments: [Appointment] = []
    private let displayFormatter: DateFormatter
    
    init(displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, h:mm a"
        return formatter
    }()) {
        self.displayFormatter = displayFormatter
    }
    
    func loadAppointments(completion: @escaping () -> Void) {
        SmartBookingService.shared.fetchAppointments { [weak self] appointments, _ in
            guard let self = self else { return }
            self.appointments = appointments ?? []
            completion()
        }
    }
    
    var upcomingAppointments: [Appointment] {
        filterAppointments(isUpcoming: true)
    }
    
    var pastAppointments: [Appointment] {
        filterAppointments(isUpcoming: false)
    }
    
    private func filterAppointments(isUpcoming: Bool) -> [Appointment] {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        
        let filtered = appointments.compactMap { appointment -> Appointment? in
            guard let dateStr = appointment.date,
                  let date = formatter.date(from: dateStr) else { return nil }
            return isUpcoming ? (date >= now ? appointment : nil)
            : (date < now ? appointment : nil)
        }
        
        return filtered.sorted {
            guard let d1 = formatter.date(from: $0.date ?? ""),
                  let d2 = formatter.date(from: $1.date ?? "") else { return false }
            return isUpcoming ? d1 < d2 : d1 > d2
        }
    }
}
