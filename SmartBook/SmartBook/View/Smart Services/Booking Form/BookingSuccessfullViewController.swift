//
//  BookedFormViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/9/25.
//

import UIKit

final class BookingSuccessfullViewController: UIViewController {
    @IBOutlet var bookingSuccessfulLabel: UILabel!
    @IBOutlet var bookedSuccessfulMessageLabel: UILabel!
    @IBOutlet var goToHomescreenButton: UIButton!
    @IBOutlet var bookedSuccessfulBackgroundView: UIView!
    
    private var viewModel: BookingSuccessfullViewModel!
    var appointmentDate: Date!
    var appointmentTime: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Booked Successfully"
        setupUI()
        setupViewModel()
        updateUI()
    }
    
    private func setupUI() {
        goToHomescreenButton.applyRoundBorder()
        bookingSuccessfulLabel.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulMessageLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        goToHomescreenButton.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulBackgroundView.applyBorderRound()
    }
    
    private func setupViewModel() {
        viewModel = BookingSuccessfullViewModel(appointmentDate: appointmentDate, appointmentTime: appointmentTime)
    }
    
    @IBAction func goToHomescreenButtonAction(_ sender: Any) {
        viewModel.goToHome()
    }
    
    private func updateUI() {
        bookingSuccessfulLabel.text = viewModel.bookingSuccessTitle
        bookedSuccessfulMessageLabel.text = viewModel.bookingConfirmationMessage
        goToHomescreenButton.setTitle(viewModel.goHomeButtonTitle, for: .normal)
    }
}
