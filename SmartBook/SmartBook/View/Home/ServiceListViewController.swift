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
    }
    
    private func configureTableView() {
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
        
        if indexPath.row == 0 {
            let healthcareVC = StoryboardInfo.instantiateVC(
                from: .healthcareField,
                identifier: StoryboardInfo.Identifier.healthcareFieldVC
            )
            (self.parent as? RootViewController)?.pushChildViewController(healthcareVC, title: "Healthcare Fields")
        } else {
            print("Tapped on: \(viewModel.serviceName(at: indexPath.row))")
        }
    }

}
