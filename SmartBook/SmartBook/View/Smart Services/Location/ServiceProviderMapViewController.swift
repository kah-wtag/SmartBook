//
//  ServiceProviderMapViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 22/9/25.
//

import UIKit
import MapKit

class ServiceProviderMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: ServiceProviderMapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        setupMap()
    }
    
    private func setupMap() {
        guard viewModel.isLocationAvailable,
              let annotation = viewModel.annotation(),
              let region = viewModel.mapRegion else {
            present(viewModel.locationUnavailableAlert, animated: true)
            return
        }
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
}

