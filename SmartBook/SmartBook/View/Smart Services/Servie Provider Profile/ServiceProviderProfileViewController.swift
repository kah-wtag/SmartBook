//
//  ServiceProviderProfileViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 19/8/25.
//

import UIKit

final class ServiceProviderProfileViewController: UIViewController {
    @IBOutlet var bookAppointmentButton: UIButton!
    @IBOutlet var mapViewButton: UIButton!
    @IBOutlet var professionalsImageView: UIImageView!
    @IBOutlet var professionalsProfileName: UILabel!
    @IBOutlet var professionalsProfilePatientNumber: UILabel!
    @IBOutlet var medicalCollege: UILabel!
    @IBOutlet var professionalsProfileExperience: UILabel!
    @IBOutlet var professionalsFieldName: UILabel!
    @IBOutlet var professionalsDegree: UILabel!
    @IBOutlet var professionalsPersonalBio: UILabel!
    @IBOutlet var professionalsPersonalBioDetials: UILabel!
    
    var viewModel: ServiceProviderProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.nameText
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        setupViewAppearance()
        setupButtonFontSize()
        setupLabelFontSize()
        setupTextColor()
    }
    
    private func setupButtonFontSize() {
        bookAppointmentButton.setFont(.large, weight: .medium, dynamic: true, title: "Book Appointment")
        mapViewButton.setFont(.regular, weight: .medium, dynamic: true, title: "Map")
    }
    
    private func setupLabelFontSize() {
        professionalsProfileName.setFontSize(.large, weight: .bold, dynamic: true)
        professionalsProfilePatientNumber.setFontSize(.regular, weight: .regular, dynamic: true)
        professionalsProfileExperience.setFontSize(.regular, weight: .regular, dynamic: true)
        medicalCollege.setFontSize(.small, weight: .thin, dynamic: true)
        professionalsPersonalBio.setFontSize(.regular, weight: .medium, dynamic: true)
        professionalsPersonalBioDetials.setFontSize(.small, weight: .thin, dynamic: true)
        professionalsFieldName.setFontSize(.regular, weight: .medium, dynamic: true)
        professionalsDegree.setFontSize(.small, weight: .thin, dynamic: true)
    }
    
    private func setupViewAppearance() {
        professionalsImageView.makeCircular()
        mapViewButton.applyRoundBorder()
        bookAppointmentButton.applyRoundBorder()
    }
    
    private func setupTextColor() {
        professionalsProfileName.textColor = .primaryText
        professionalsProfilePatientNumber.textColor = .primaryText
        medicalCollege.textColor = .primaryText
        professionalsProfileExperience.textColor = .primaryText
        professionalsFieldName.textColor = .primaryText
        professionalsDegree.textColor = .primaryText
        professionalsPersonalBio.textColor = .primaryText
        professionalsPersonalBioDetials.textColor = .primaryText
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        let vc = Routes.serviceProviderMapVC
        vc.viewModel = ServiceProviderMapViewModel(provider: viewModel.provider)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bookAppointmentButtonTapped(_ sender: UIButton) {
        let bookingFormVC = Routes.bookingFormVC
        bookingFormVC.viewModel.setServiceProviderName(viewModel.nameText)
        bookingFormVC.viewModel.setMinimumAdvanceTime(viewModel.minimumAdvanceTime)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(bookingFormVC, animated: true)
    }
    
    private func updateUI() {
        professionalsProfileName.text = viewModel.nameText
        professionalsProfileExperience.text = viewModel.experienceText
        professionalsFieldName.text = viewModel.fieldText
        professionalsImageView.image = viewModel.image
        professionalsProfilePatientNumber.text = viewModel.patientCountText
        professionalsDegree.text = viewModel.degreesText
        medicalCollege.text = viewModel.institutionText
        professionalsPersonalBioDetials.text = viewModel.bioText
    }
}
