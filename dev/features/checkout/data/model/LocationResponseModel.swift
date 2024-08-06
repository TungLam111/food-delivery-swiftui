//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

struct LocationResponseModel: Codable, Hashable {
    let id: String
    let address: String
    let name: String
    let latitude: Double
    let longtitude: Double
    let ggPlaceId: String;
    let userId: String;
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
        case name
        case latitude
        case longtitude
        case ggPlaceId
        case userId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longtitude = try container.decode(Double.self, forKey: .longtitude)
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.ggPlaceId = try container.decode(String.self, forKey: .ggPlaceId)
    }
}

