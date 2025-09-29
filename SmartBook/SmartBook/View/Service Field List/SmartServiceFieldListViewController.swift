//
//  SmartServiceFieldListViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class SmartServiceFieldListViewController: UIViewController {
    
    @IBOutlet private var smartServiceFieldCollectionView: UICollectionView!
    @IBOutlet var noServiceFieldsLabel: UILabel!
    
    var viewModel: SmartServiceFieldListViewModel!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        configureCollectionView()
        setupUI()
        setupViewModelCommunication()
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
    
    private func setupViewModelCommunication() {
        viewModel.delegate = self
        viewModel.fetchFields()
    }
    
    @objc private func refreshData() {
        viewModel.fetchFields()
    }
}

extension SmartServiceFieldListViewController: SmartServiceFieldListViewModelDelegate {
    
    func didUpdateFields() {
        smartServiceFieldCollectionView.reloadData()
        refreshControl.endRefreshing()
        updateUIForDataAvailability()
    }
    
    private func updateUIForDataAvailability() {
        let hasData = viewModel.numberOfFields() > 0
        smartServiceFieldCollectionView.isHidden = !hasData
        noServiceFieldsLabel.isHidden = hasData
    }
}

extension SmartServiceFieldListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfFields()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Routes.Identifier.smartServiceFieldListCell,
            for: indexPath
        ) as! SmartServiceFieldListCell
        
        let field = viewModel.field(at: indexPath.item)
        cell.configure(with: field)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = viewModel.field(at: indexPath.item)
    }
}
