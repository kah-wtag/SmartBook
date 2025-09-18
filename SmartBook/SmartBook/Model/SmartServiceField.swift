//
//  SmartServiceField.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 25/9/25.
//

import UIKit

struct SmartServiceField: Codable {
    let fieldTypeID: Int?
    let fieldName: String?
    let iconName: String?
    let serviceProvider: [ServiceProvider]?
    
    var serviceProviderCount: Int {
        serviceProvider?.count ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldTypeID
        case fieldName
        case iconName
        case serviceProvider
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fieldTypeID = try container.decodeIfPresent(Int.self, forKey: .fieldTypeID)
        fieldName = try container.decodeIfPresent(String.self, forKey: .fieldName)
        iconName = try container.decodeIfPresent(String.self, forKey: .iconName)
        serviceProvider = try container.decodeIfPresent([ServiceProvider].self, forKey: .serviceProvider)
    }
}
