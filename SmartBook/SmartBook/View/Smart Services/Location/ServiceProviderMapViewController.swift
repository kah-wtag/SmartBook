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
    
    var professional: ProfessionalsViewModel.Professional?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfessionalLocation()
    }
    
    private func showProfessionalLocation() {
        guard let doctor = professional else { return }
        let coordinate = CLLocationCoordinate2D(latitude: doctor.latitude, longitude: doctor.longitude)
        let annotation = MKPointAnnotation()
        annotation.title = doctor.name
        annotation.subtitle = doctor.field
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
}

