//
//  ServiceListViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 4/8/25.
//

import UIKit

class ServiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var services = ["Doctor", "Therapy", "Lawyer", "Salon", "Spa", "Beauty Parlour", "Tutoring", "Car Mechanics", "Electrician", "Designer"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Service", for: indexPath) as? ServiceCell else {
                    return UITableViewCell()
                }
                
                cell.textLabel?.text = services[indexPath.row]
                return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Accessory button tapped for row \(indexPath.row)")
    }
    
    
    @IBOutlet var serviceListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceListTableView.delegate = self
        serviceListTableView.dataSource = self
        
        serviceListTableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
        
        serviceListTableView.tableFooterView = UIView()
    }
    
}

