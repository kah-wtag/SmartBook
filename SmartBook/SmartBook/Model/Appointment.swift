//
//  Appointment.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 8/10/25.
//

import UIKit

struct Appointment: Codable {
    let id: String
    let serviceName: String?
    let serviceFieldName: String?
    let providerName: String?
    let date: String?
    let time: String?
    var isUnread: Bool?
    var dateRead: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceName
        case serviceFieldName
        case providerName
        case date
        case time
        case isUnread
        case dateRead
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        serviceName = try container.decodeIfPresent(String.self, forKey: .serviceName)
        serviceFieldName = try container.decodeIfPresent(String.self, forKey: .serviceFieldName)
        providerName = try container.decodeIfPresent(String.self, forKey: .providerName)
        date = try container.decodeIfPresent(String.self, forKey: .date)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        isUnread = try container.decodeIfPresent(Bool.self, forKey: .isUnread) ?? true
        dateRead = try container.decodeIfPresent(String.self, forKey: .dateRead)
    }
    
    init(
        id: String = UUID().uuidString,
        serviceName: String? = nil,
        serviceFieldName: String? = nil,
        providerName: String? = nil,
        date: String? = nil,
        time: String? = nil
    ) {
        self.id = id
        self.serviceName = serviceName
        self.serviceFieldName = serviceFieldName
        self.providerName = providerName
        self.date = date
        self.time = time
    }
}
