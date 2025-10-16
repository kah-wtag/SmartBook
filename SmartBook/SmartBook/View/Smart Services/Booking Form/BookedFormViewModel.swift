//
//  BookedFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import UIKit

final class BookedFormViewModel {
    
    let bookingSuccessTitle = "Congratulations!!"
    let goHomeButtonTitle = "Go to Services"
    
    private(set) var bookingSuccessMessage: String = ""
    
    init(appointmentDate: Date, appointmentTime: Date) {
        bookingSuccessMessage = generateBookingMessage(appointmentDate: appointmentDate, appointmentTime: appointmentTime)
    }
    
    private func generateBookingMessage(appointmentDate: Date, appointmentTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

        return "Your appointment has been successfully booked on \(dateFormatter.string(from: appointmentDate)) at \(timeFormatter.string(from: appointmentTime))."
    }
    
    func goToHome() {
        Routes.displayRootScreen()
    }
}

