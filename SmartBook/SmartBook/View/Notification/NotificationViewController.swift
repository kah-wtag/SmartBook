//
//  NotificationViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 4/9/25.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    @IBOutlet var notificationTableView: UITableView!
    @IBOutlet var noNotificationLabel: UILabel!
    
    private var viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadNotifications()
    }
    
    private func setupTableView() {
        notificationTableView.dataSource = self
        notificationTableView.delegate = self
    }
    
    private func loadNotifications() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self else { return }
            
            let hasNotifications = self.viewModel.numberOfNotifications > 0
            self.noNotificationLabel.isHidden = hasNotifications
            self.notificationTableView.isHidden = !hasNotifications
            
            if hasNotifications {
                self.notificationTableView.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self.notificationTableView.scrollToRow(
                    at: indexPath, at: .middle, animated: true
                )
            }
        }
        viewModel.loadAppointments()
    }
}

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfNotifications
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.notificationCell,
            for: indexPath
        ) as! NotificationTableViewCell
        
        cell.viewModel = viewModel.notificationCellViewModel(at: indexPath.row)
        cell.updateUI()
        return cell
    }
}
