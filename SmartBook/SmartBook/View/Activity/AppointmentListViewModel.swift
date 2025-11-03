//
//  AppointmentListViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import Foundation

protocol AppointmentListViewModelDelegate: AnyObject {
    func didUpdateAppointments()
    func didFailFetchingAppointments(with error: Error)
}

final class AppointmentListViewModel {
    
    private var appointments: [Appointment] = []
    weak var delegate: AppointmentListViewModelDelegate?
    
    var upcomingAppointments: [Appointment] {
        filterAppointments(isUpcoming: true)
    }
    
    var pastAppointments: [Appointment] {
        filterAppointments(isUpcoming: false)
    }
    
    var numberOfPastAppointments: Int {
        pastAppointments.count
    }
    
    var numberOfUpcomingAppointments: Int {
        upcomingAppointments.count
    }
    
    init() { }
    
    func loadAppointments(completion: @escaping () -> Void) {
        SmartBookingService.shared.fetchAppointments { [weak self] appointments, _ in
            guard let self else { return }
            self.appointments = appointments ?? []
            completion()
        }
    }
    
    private func filterAppointments(isUpcoming: Bool) -> [Appointment] {
        let now = Date()
        
        let filtered = appointments.compactMap { appointment -> Appointment? in
            guard let dateStr = appointment.date,
                  let date = DateFormatter.appointmentDateParser.date(
                    from: dateStr
                  ) else {
                return nil
            }
            return isUpcoming ? (date >= now ? appointment : nil)
            : (date < now ? appointment : nil)
        }
        
        return filtered.sorted {
            guard let d1 = DateFormatter.appointmentDateParser.date(
                from: $0.date ?? ""
            ),
                  let d2 = DateFormatter.appointmentDateParser.date(
                    from: $1.date ?? ""
                  ) else {
                return false
            }
            return isUpcoming ? d1 < d2 : d1 > d2
        }
    }
    
#if DEBUG
    func setAppointmentsForTesting(_ appointments: [Appointment]?, error: Error? = nil) {
        if let error = error {
            delegate?.didFailFetchingAppointments(with: error)
        } else {
            self.appointments = appointments ?? []
            delegate?.didUpdateAppointments()
        }
    }
#endif
}

extension AppointmentListViewModel {
    func pastAppointmentCellViewModel(at index: Int) -> AppointmentCellViewModel? {
        guard pastAppointments.indices.contains(index) else { return nil }
        return AppointmentCellViewModel(appointment: pastAppointments[index])
    }
    
    func upcomingAppointmentCellViewModel(at index: Int) -> AppointmentCellViewModel? {
        guard upcomingAppointments.indices.contains(index) else { return nil }
        return AppointmentCellViewModel(appointment: upcomingAppointments[index])
    }
}
