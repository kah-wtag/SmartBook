//
//  UpcomingAppointmentListViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 28/8/25.
//

import UIKit

final class UpcomingAppointmentListViewController: UIViewController {
    
    @IBOutlet var appointmentListTableView: UITableView!
    
    var viewModel: AppointmentListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addTableViewHeaderLine()
        appointmentListTableView.reloadData()
    }
    
    private func setupTableView() {
        appointmentListTableView.dataSource = self
        appointmentListTableView.delegate = self
    }
    
    private func addTableViewHeaderLine() {
        let headerLine = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: appointmentListTableView.frame.width,
                height: 1
            )
        )
        headerLine.backgroundColor = .separator
        appointmentListTableView.tableHeaderView = headerLine
    }
}

extension UpcomingAppointmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfUpcomingAppointments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.appointmentCell,
            for: indexPath
        ) as! AppointmentListTableViewCell
        
        cell.viewModel = viewModel.upcomingAppointmentCellViewModel(at: indexPath.row)
        cell.updateUI()
        
        return cell
    }
}
