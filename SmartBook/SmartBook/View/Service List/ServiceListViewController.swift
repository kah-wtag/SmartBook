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
        bindViewModel()
    }
    
    private func configureTableView() {
        serviceListTableView.delegate = self
        serviceListTableView.dataSource = self
        //            serviceListTableView.tableFooterView = UIView()
        view.backgroundColor = .background
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.serviceListTableView.reloadData()
        }
        viewModel.fetchServices()
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
        if let label = cell.textLabel {
            label.text = viewModel.serviceName(at: indexPath.row)
            label.setFontSize(.large, weight: .medium, dynamic: true)
            label.textColor = .primaryText
        }
        cell.backgroundColor = .background
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectService(at: indexPath.row, navigationController: navigationController)
    }
}
