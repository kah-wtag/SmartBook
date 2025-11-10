//
//  BookedFormViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 7/10/25.
//

import UIKit

final class BookingSuccessfullViewModel {
    
    private let appointmentDate: Date
    private let appointmentTime: Date
    
    let bookingSuccessTitle = "Congratulations!!"
    let goHomeButtonTitle = "Go to Services"
    
    init(appointmentDate: Date, appointmentTime: Date) {
        self.appointmentDate = appointmentDate
        self.appointmentTime = appointmentTime
    }
    
    var bookingConfirmationMessage: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        return "Your appointment is scheduled on \(dateFormatter.string(from: appointmentDate)) at \(timeFormatter.string(from: appointmentTime))."
    }
    
    func goToHome() {
        Routes.displayRootScreen()
    }
}
