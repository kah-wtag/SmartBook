//
//  BookedFormViewController.swift
//  WelldevTraining BookingForm
//
//  Created by Md. Kamrul Hasan on 3/9/25.
//

import UIKit

class BookedFormViewController: UIViewController {
    @IBOutlet var bookingSuccessfulLabel: UILabel!
    @IBOutlet var bookedSuccessfulMessageLabel: UILabel!
    @IBOutlet var goToHomescreenButton: UIButton!
    
    private let viewModel = BookedFormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard bookingSuccessfulLabel != nil,
              bookedSuccessfulMessageLabel != nil,
              goToHomescreenButton != nil else {
            fatalError("IBOutlets not connected in BookedFormViewController")
        }
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        goToHomescreenButton.applyRoundBorder()
        bookingSuccessfulLabel.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulMessageLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        goToHomescreenButton.setFontSize(.large, weight: .bold, dynamic: true)
    }
    
    @IBAction func goToHomescreenButtonAction(_ sender: Any) {
        viewModel.goToHome()
    }
    
    private func updateUI() {
        bookingSuccessfulLabel.text = viewModel.bookingSuccessTitle
        bookedSuccessfulMessageLabel.text = viewModel.bookingSuccessMessage
        goToHomescreenButton.setTitle(viewModel.goHomeButtonTitle, for: .normal)
    }
}
