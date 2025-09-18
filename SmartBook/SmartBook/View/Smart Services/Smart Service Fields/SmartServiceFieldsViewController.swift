//
//  SmartServiceFieldsViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServiceFieldsViewController: UIViewController {
    
    @IBOutlet var smartServiceFieldCollectionView: UICollectionView!
    @IBOutlet var noServiceFieldsLabel: UILabel!
    
    var viewModel: SmartServiceFieldsViewModel!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        configureCollectionView()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchFields()
    }
    
    private func configureCollectionView() {
        smartServiceFieldCollectionView.delegate = self
        smartServiceFieldCollectionView.dataSource = self
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        smartServiceFieldCollectionView.collectionViewLayout = layout
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        smartServiceFieldCollectionView.refreshControl = refreshControl
        noServiceFieldsLabel.isHidden = true
    }
    
    private func setupUI() {
        noServiceFieldsLabel.setFontSize(.regular, dynamic: true)
        setupTextColor()
    }
    
    private func setupTextColor() {
        noServiceFieldsLabel.textColor = .primaryText
    }
    
    @objc private func refreshData() {
        viewModel.fetchFields()
    }
}

extension SmartServiceFieldsViewController: SmartServiceFieldsViewModelDelegate {
    
    func didUpdateFields() {
        smartServiceFieldCollectionView.reloadData()
        stopRefreshing()
        updateUIForDataAvailability()
    }
    
    private func updateUIForDataAvailability() {
        let hasData = viewModel.numberOfFields > 0
        smartServiceFieldCollectionView.isHidden = !hasData
        noServiceFieldsLabel.isHidden = hasData
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

extension SmartServiceFieldsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfFields
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Routes.Identifier.smartServiceFieldCell,
            for: indexPath
        ) as! SmartServiceFieldCell
        cell.viewModel = viewModel.cellViewModel(for: indexPath.item)
        cell.updateUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let serviceProviderViewModel = viewModel.serviceProviderViewModel(for: indexPath.item) else {
            return
        }
        let serviceProviderVC = Routes.serviceProviderVC
        serviceProviderVC.viewModel = serviceProviderViewModel
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(serviceProviderVC, animated: true)
    }
}

extension SmartServiceFieldsViewController {
    
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
