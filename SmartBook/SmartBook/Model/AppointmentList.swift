//
//  AppointmentListResponse.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 26/10/25.
//

struct AppointmentList: Codable {
    let appointments: [Appointment]
    
    enum CodingKeys: String, CodingKey {
        case appointments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appointments = try container.decodeIfPresent([Appointment].self, forKey: .appointments) ?? []
    }
}
