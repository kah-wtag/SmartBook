//
//  UpcomingAppointmentListViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 28/8/25.
//

import UIKit

class UpcomingAppointmentListViewController: UIViewController {
    
    @IBOutlet var appointmentListTableView: UITableView!
    var viewModel: AppointmentListViewModel!
    private var upcomingAppointments: [Appointment] {
        viewModel.upcomingAppointments
    }
    
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
        appointmentListTableView.reloadData()
    }
    
    private func setupTableView() {
        appointmentListTableView.dataSource = self
        appointmentListTableView.delegate = self
    }
}

extension UpcomingAppointmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        upcomingAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.appointmentCell,
            for: indexPath
        ) as! AppointmentListTableViewCell
        
        let appointment = upcomingAppointments[indexPath.row]
        let cellVM = AppointmentCellViewModel(appointment: appointment)
        cell.configure(with: cellVM)
        
        return cell
    }
}
