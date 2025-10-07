//
//  BookedFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import Foundation

final class BookedFormViewModel {
    
    let bookingSuccessTitle = "Booking Successful"
    let bookingSuccessMessage = "Your appointment has been successfully booked."
    let goHomeButtonTitle = "Go to Services"
    
    func goToHome() {
        Routes.displayRootScreen()
    }
}
