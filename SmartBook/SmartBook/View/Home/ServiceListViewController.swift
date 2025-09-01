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
        view.backgroundColor = .background
        serviceListTableView.delegate = self
        serviceListTableView.dataSource = self
        serviceListTableView.tableFooterView = UIView()
    }
}

extension ServiceListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServices()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StoryboardInfo.Identifier.serviceListCell,
            for: indexPath
        )
        cell.textLabel?.text = viewModel.serviceName(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let healthcareVC = StoryboardInfo.instantiateVC(
            from: .healthcareField,
            identifier: StoryboardInfo.Identifier.healthcareFieldVC
        ) as! HealthcareFieldViewController
        healthcareVC.title = "Healthcare Fields"
        navigationController?.pushViewController(healthcareVC, animated: true)
    }
}
