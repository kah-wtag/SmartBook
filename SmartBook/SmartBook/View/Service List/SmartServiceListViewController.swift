//
//  SmartServiceListViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServiceListViewController: UIViewController {
    
    @IBOutlet var smartServiceListTableView: UITableView!
    @IBOutlet var noServiceLabel: UILabel!
    
    private let viewModel = SmartServiceListViewModel()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupUI()
        setupViewModelCommunication()
    }
    
    private func configureTableView() {
        smartServiceListTableView.delegate = self
        smartServiceListTableView.dataSource = self
        noServiceLabel.setFontSize(.regular, dynamic: true)
        view.backgroundColor = .background
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        smartServiceListTableView.refreshControl = refreshControl
        noServiceLabel.isHidden = true
    }
    
    private func setupUI() {
        noServiceLabel.setFontSize(.regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        noServiceLabel.textColor = .primaryText
    }
    
    private func setupViewModelCommunication() {
        viewModel.delegate = self
        viewModel.fetchServices()
    }
    
    @objc private func refreshData() {
        viewModel.fetchServices()
    }
}

extension SmartServiceListViewController: SmartServiceListViewModelDelegate {
    
    func didUpdateServices() {
        updateUIForDataAvailability()
        smartServiceListTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func updateUIForDataAvailability() {
        let hasData = viewModel.numberOfServices() > 0
        smartServiceListTableView.isHidden = !hasData
        noServiceLabel.isHidden = hasData
    }
}

extension SmartServiceListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServices()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.smartServiceListCell,
            for: indexPath
        )
        if let label = cell.textLabel {
            label.text = viewModel.serviceName(at: indexPath.row)
            label.setFontSize(.large, weight: .medium, dynamic: true)
            label.textColor = .primaryText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectService(at: indexPath.row, navigationController: navigationController)
    }
}
