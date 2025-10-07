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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        goToHomescreenButton.applyRoundBorder()
        bookingSuccessfulLabel.setFontSize(.large, weight: .bold, dynamic: true)
        bookedSuccessfulMessageLabel.setFontSize(.regular, weight: .regular, dynamic: true)
        goToHomescreenButton.setFontSize(.large, weight: .bold, dynamic: true)
    }
    
    @IBAction func goToHomescreenButtonAction(_ sender: Any) {
        Routes.displayRootScreen()
    }
}
