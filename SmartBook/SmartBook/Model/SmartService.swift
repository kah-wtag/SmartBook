//
//  SmartService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 24/9/25.
//

import UIKit

struct SmartService: Codable {   
    let serviceID: Int?
    let serviceName: String?
    let fields: [SmartServiceField]?
    
    enum CodingKeys: String, CodingKey {
        case serviceID
        case serviceName
        case fields
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        serviceID = try container.decodeIfPresent(Int.self, forKey: .serviceID)
        serviceName = try container.decodeIfPresent(String.self, forKey: .serviceName)
        fields = try container.decodeIfPresent([SmartServiceField].self, forKey: .fields)
    }
}
