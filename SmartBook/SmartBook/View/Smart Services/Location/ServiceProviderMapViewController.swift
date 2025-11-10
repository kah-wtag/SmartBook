//
//  ServiceProviderMapViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 22/9/25.
//

import UIKit
import MapKit

final class ServiceProviderMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: ServiceProviderMapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        setupMap()
    }
    
    private func setupMap() {
        guard let annotation = viewModel.annotation(),
              let region = viewModel.mapRegion else { return }
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
}

