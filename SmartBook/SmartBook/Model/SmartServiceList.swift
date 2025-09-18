//
//  SmartServiceList.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 28/9/25.
//

import UIKit

struct SmartServiceList: Codable {   
    let services: [SmartService]?  
    
    enum CodingKeys: String, CodingKey {
        case services
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        services = try container.decodeIfPresent([SmartService].self, forKey: .services)
    }
}
