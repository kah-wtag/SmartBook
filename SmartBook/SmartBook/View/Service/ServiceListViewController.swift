//
//  ServiceListViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

class ServiceListViewController: UIViewController {
    
    @IBOutlet var serviceListTableView: UITableView!
    
    private let viewModel = ServiceListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        serviceListTableView.tableFooterView = UIView()
    }
    
    private func configureTableView() {
        view.backgroundColor = .background
        serviceListTableView.delegate = self
        serviceListTableView.dataSource = self
    }
}

extension ServiceListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServices()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.serviceListCell,
            for: indexPath
        )
        cell.textLabel?.text = viewModel.serviceName(at: indexPath.row)
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            Routes.showHealthcareField(from: navigationController)
        } else {
            let serviceName = viewModel.serviceName(at: indexPath.row)
            print("Service clicked: \(serviceName)")
        }
    }
}
