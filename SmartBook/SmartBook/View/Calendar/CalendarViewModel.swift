//
//  CalendarViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 26/10/25.
//

import Foundation

final class CalendarViewModel {
    
    private let appointmentListVM: AppointmentListViewModel
    
    var upcomingAppointments: [Appointment] {
        appointmentListVM.upcomingAppointments
    }
    
    init(appointmentListVM: AppointmentListViewModel) {
        self.appointmentListVM = appointmentListVM
    }
    
    func hasAppointment(on date: Date) -> Bool {
        let calendar = Calendar.current
        return upcomingAppointments.contains {
            guard let dateStr = $0.date,
                  let appointmentDate = ISO8601DateFormatter().date(from: dateStr) else { return false }
            return calendar.isDate(appointmentDate, inSameDayAs: date)
        }
    }
}
