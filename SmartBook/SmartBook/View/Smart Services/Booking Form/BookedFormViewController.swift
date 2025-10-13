//
//  BookedFormViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 3/9/25.
//

import UIKit

final class BookedFormViewController: UIViewController {
    @IBOutlet var bookingSuccessfulLabel: UILabel!
    @IBOutlet var bookedSuccessfulMessageLabel: UILabel!
    @IBOutlet var goToHomescreenButton: UIButton!
    @IBOutlet var bookedSuccessfulBackgroundView: UIView!
    
    private let viewModel = BookedFormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Booked Successfully"
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        goToHomescreenButton.applyRoundBorder()
        bookingSuccessfulLabel.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulMessageLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        goToHomescreenButton.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulBackgroundView.applyBorderRound()
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
