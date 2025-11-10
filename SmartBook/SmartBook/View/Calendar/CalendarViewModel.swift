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
    
    var numberOfUpcomingAppointments: Int {
        upcomingAppointments.count
    }
    
    init(appointmentListVM: AppointmentListViewModel) {
        self.appointmentListVM = appointmentListVM
    }
    
    func hasAppointment(on date: Date) -> Bool {
        let calendar = Calendar.current
        return appointmentListVM.upcomingAppointments.contains { appointment in
            guard let appointmentDate = DateTimeHelper.date(
                from: appointment.date,
                format: DateFormat.yyyy_MM_dd_HH_mm_ss_Z
            ) else { return false }
            return calendar.isDate(appointmentDate, inSameDayAs: date)
        }
    }
    
    func allUpcomingDateComponents() -> [DateComponents] {
        let calendar = Calendar.current
        return upcomingAppointments.compactMap { appointment in
            guard let date = DateTimeHelper.date(
                from: appointment.date,
                format: DateFormat.yyyy_MM_dd_HH_mm_ss_Z
            ) else { return nil }
            return calendar.dateComponents([.year, .month, .day], from: date)
        }
    }
    
    func displayText(for index: Int) -> String {
        guard upcomingAppointments.indices.contains(index) else { return "N/A" }
        
        let appointment = upcomingAppointments[index]
        
        let dateText = DateTimeHelper.convertToDate(
            dateString: appointment.date,
            from: DateFormat.yyyy_MM_dd_HH_mm_ss_Z,
            to: DateFormat.dd_MMM_yyyy
        )
        
        let providerName = appointment.providerName ?? "Unknown"
        let timeText = appointment.time ?? "N/A"
        
        return "\(dateText) - \(providerName)\nTime: \(timeText)"
    }
}
