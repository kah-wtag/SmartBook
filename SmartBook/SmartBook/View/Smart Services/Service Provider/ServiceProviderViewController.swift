//
//  ServiceProviderViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 17/8/25.
//

import UIKit

final class ServiceProviderViewController: UIViewController {
    @IBOutlet var serviceProviderTableView: UITableView!
    @IBOutlet var noServiceProviderLabel: UILabel!
    
    var viewModel: ServiceProviderViewModel!
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        configureTableView()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchServiceProviders()
    }
    
    private func configureTableView() {
        serviceProviderTableView.delegate = self
        serviceProviderTableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        serviceProviderTableView.refreshControl = refreshControl
        serviceProviderTableView.isHidden = true
    }
    
    private func setupUI() {
        noServiceProviderLabel.isHidden = true
        noServiceProviderLabel.setFontSize(.regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        noServiceProviderLabel.textColor = .primaryText
    }
    
    @objc private func refreshData() {
        viewModel.fetchServiceProviders()
    }
}

extension ServiceProviderViewController: ServiceProviderViewModelDelegate {
    
    func didUpdateProfessionals() {
        updateUIForDataAvailability()
        serviceProviderTableView.reloadData()
        stopRefreshing()
    }
    
    private func updateUIForDataAvailability() {
        let hasData = viewModel.numberOfServiceProvider > 0
        serviceProviderTableView.isHidden = !hasData
        noServiceProviderLabel.isHidden = hasData
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

extension ServiceProviderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServiceProvider
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Routes.Identifier.serviceProviderCell,
            for: indexPath
        ) as! ServiceProviderCell
        cell.viewModel = viewModel.providerCellViewModel(at: indexPath.row)
        cell.updateUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let profileVM = viewModel.serviceProviderProfileViewModel(for: indexPath.row) else { return }
        let profileVC = Routes.serviceProviderProfileVC
        profileVC.viewModel = profileVM
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension ServiceProviderViewController {
    
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
