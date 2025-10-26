//
//  PastAppointmentListViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 28/8/25.
//

import UIKit

class PastAppointmentListViewController: UIViewController {
    
    @IBOutlet var appointmentListTableView: UITableView!
    var viewModel: AppointmentListViewModel!
    
    private var pastAppointments: [Appointment] {
        viewModel.pastAppointments
    }
    
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

extension PastAppointmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pastAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.appointmentCell,
            for: indexPath
        ) as! AppointmentListTableViewCell
        
        let appointment = pastAppointments[indexPath.row]
        let cellVM = AppointmentCellViewModel(appointment: appointment)
        cell.configure(with: cellVM)
        
        return cell
    }
}
