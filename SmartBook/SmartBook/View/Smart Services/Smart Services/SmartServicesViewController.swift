//
//  SmartServicesViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServicesViewController: UIViewController {
    
    @IBOutlet var smartServicesTableView: UITableView!
    @IBOutlet var noServiceLabel: UILabel!
    
    private let viewModel = SmartServicesViewModel()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchServices()
    }
    
    private func configureTableView() {
        smartServicesTableView.delegate = self
        smartServicesTableView.dataSource = self
        noServiceLabel.setFontSize(.regular, dynamic: true)
        view.backgroundColor = .background
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        smartServicesTableView.refreshControl = refreshControl
        noServiceLabel.isHidden = true
    }
    
    private func setupUI() {
        noServiceLabel.setFontSize(.regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        noServiceLabel.textColor = .primaryText
    }
    
    @objc private func refreshData() {
        viewModel.fetchServices()
    }
}

extension SmartServicesViewController: SmartServicesViewModelDelegate {
    
    func didUpdateServices() {
        updateUIForDataAvailability()
        smartServicesTableView.reloadData()
        stopRefreshing()
    }
    
    private func updateUIForDataAvailability() {
        let hasData = viewModel.numberOfServices > 0
        smartServicesTableView.isHidden = !hasData
        noServiceLabel.isHidden = hasData
    }
    
    func didFailedWithError() {
        showAlert(
            title: "Error",
            message: "Something went wrong. Please try again."
        )
        stopRefreshing()
    }
    
    private func stopRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension SmartServicesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServices
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.smartServiceCell,
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
        guard let fieldsVM = viewModel.serviceFieldsViewModel(for: indexPath.row) else { return }
        let fieldVC = Routes.smartServiceFieldsVC
        fieldVC.viewModel = fieldsVM
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(fieldVC, animated: true)
    }
}

extension SmartServicesViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
