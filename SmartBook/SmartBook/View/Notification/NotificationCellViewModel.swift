//
//  NotificationCellViewModel.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 27/10/25.
//

import UIKit

final class NotificationCellViewModel {
    
    private let appointment: Appointment
    
    init(appointment: Appointment) {
        self.appointment = appointment
    }
    
    var notificationMessage: NSAttributedString {
        let providerName = appointment.providerName ?? "Unknown"
        let date = DateTimeHelper.convertToDate(
            dateString: appointment.date,
            from: DateFormat.yyyy_MM_dd_HH_mm_ss_Z,
            to: DateFormat.dd_MMM_yyyy
        )
        let time = appointment.time ?? "N/A"
        
        let htmlString = """
        Your appointment with <b style="font-size:17px">\(providerName)</b> has been scheduled at <b style="font-size:17px">\(date)</b> at <b style="font-size:17px">\(time)</b>
        """
        return NSAttributedString.fromHTML(htmlString, fontSize: 17)
    }
    
    var showUnreadIcon: Bool {
        appointment.isUnread ?? true
    }
}
