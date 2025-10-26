//
//  AppointmentListViewController.swift
//  WelldevTraining AppointmentList
//
//  Created by Md. Kamrul Hasan on 26/8/25.
//

import UIKit

class AppointmentListViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    private enum AppointmentSegment: Int {
        case upcoming = 0
        case past = 1
    }
    
    private let viewModel = AppointmentListViewModel()
    private lazy var upcomingVC: UpcomingAppointmentListViewController? = Routes.upcomingAppointmentVC
    private lazy var pastVC: PastAppointmentListViewController? = Routes.pastAppointmentVC
    
    private var currentContainerIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        loadAppointments()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setFontSize(.regular, weight: .bold, dynamic: true)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.tabBarBackground]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
    }
    
    private func loadAppointments() {
        viewModel.loadAppointments { [weak self] in
            guard let self = self else { return }
            
            self.upcomingVC?.viewModel = self.viewModel
            self.pastVC?.viewModel = self.viewModel
            
            self.updateContainerView(.upcoming)
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let segment = AppointmentSegment(rawValue: sender.selectedSegmentIndex) else { return }
        updateContainerView(segment)
    }
    
    private func updateContainerView(_ segment: AppointmentSegment) {
        guard segment.rawValue != currentContainerIndex else { return }
        
        removeCurrentChildVC()
        
        let vcToShow: UIViewController? = segment == .upcoming ? upcomingVC : pastVC
        
        guard let child = vcToShow else { return }
        
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
        
        currentContainerIndex = segment.rawValue
    }
    
    private func removeCurrentChildVC() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
