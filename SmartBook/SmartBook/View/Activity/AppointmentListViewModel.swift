//
//  AppointmentListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import Foundation

final class AppointmentListViewModel {
    
    private(set) var appointments: [Appointment] = []
    
    func loadAppointments(completion: @escaping () -> Void) {
        SmartBookingService.shared.fetchAppointments { [weak self] appointments, _ in
            guard let self = self else { return }
            self.appointments = appointments ?? []
            completion()
        }
    }
    
    var upcomingAppointments: [Appointment] {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        return appointments.compactMap { appointment in
            guard let dateStr = appointment.date, let date = formatter.date(from: dateStr), date >= now else { return nil }
            return appointment
        }
        .sorted { formatter.date(from: $0.date!)! < formatter.date(from: $1.date!)! }
    }
    
    var pastAppointments: [Appointment] {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        return appointments.compactMap { appointment in
            guard let dateStr = appointment.date, let date = formatter.date(from: dateStr), date < now else { return nil }
            return appointment
        }
        .sorted { formatter.date(from: $0.date!)! > formatter.date(from: $1.date!)! }
    }
    
    var count: Int { appointments.count }
    
    func appointment(at index: Int) -> Appointment {
        return appointments[index]
    }
    
    func appointments(forProvider name: String) -> [Appointment] {
        return appointments.filter { $0.providerName == name }
    }
    
    func appointments(forServiceField fieldName: String) -> [Appointment] {
        return appointments.filter { $0.serviceFieldName == fieldName }
    }
}
