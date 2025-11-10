//
//  ServiceProvider.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 25/9/25.
//

import UIKit

struct ServiceProvider: Codable {
    let name: String?
    let experience: Int?
    let imageName: String?
    let latitude: Double?
    let longitude: Double?
    let clientsCount: Int?
    let bio: String?
    let degrees: [String]?
    let institution: String?
    let minimumAdvanceTime: TimeInterval?
    
    enum CodingKeys: String, CodingKey {
        case name
        case experience
        case imageName
        case latitude
        case longitude
        case clientsCount
        case bio
        case degrees
        case institution
        case minimumAdvanceTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        experience = try container.decodeIfPresent(Int.self, forKey: .experience)
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        clientsCount = try container.decodeIfPresent(Int.self, forKey: .clientsCount)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        degrees = try container.decodeIfPresent([String].self, forKey: .degrees)
        institution = try container.decodeIfPresent(String.self, forKey: .institution)
        minimumAdvanceTime = try container.decodeIfPresent(TimeInterval.self, forKey: .minimumAdvanceTime)
    }
}
