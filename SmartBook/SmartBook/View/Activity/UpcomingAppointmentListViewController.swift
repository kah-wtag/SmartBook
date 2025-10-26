//
//  UpcomingAppointmentListViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 28/8/25.
//

import UIKit

class UpcomingAppointmentListViewController: UIViewController {
    
    @IBOutlet var appointmentListTableView: UITableView!
    var viewModel = AppointmentListViewModel()
    private var upcomingAppointments: [Appointment] = []
    
    private let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()
    
    private let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadAppointments()
    }
    
    private func setupTableView() {
        appointmentListTableView.dataSource = self
        appointmentListTableView.delegate = self
    }
    
    private func loadAppointments() {
        viewModel.loadAppointments { [weak self] in
            self?.filterUpcomingAppointments()
        }
    }
    
    private func filterUpcomingAppointments() {
        let now = Date()
        
        upcomingAppointments = viewModel.appointments.compactMap { appointment in
            guard let dateString = appointment.date,
                  let date = isoFormatter.date(from: dateString),
                  date >= now else { return nil }
            return appointment
        }
        
        upcomingAppointments.sort {
            let date1 = isoFormatter.date(from: $0.date!)!
            let date2 = isoFormatter.date(from: $1.date!)!
            return date1 < date2
        }
        
        appointmentListTableView.reloadData()
    }
}

extension UpcomingAppointmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        upcomingAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.appointmentCell,
            for: indexPath
        ) as? AppointmentListTableViewCell else {
            return UITableViewCell()
        }
        
        let appointment = upcomingAppointments[indexPath.row]
        
        if let dateString = appointment.date, let date = isoFormatter.date(from: dateString) {
            cell.appointmentListDate.text = displayFormatter.string(from: date)
        } else {
            cell.appointmentListDate.text = "N/A"
        }
        
        cell.appointmentListProfessionalsName.text = appointment.providerName
        cell.appointmentListTime.text = appointment.time
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected row: \(indexPath.row)")
    }
}
