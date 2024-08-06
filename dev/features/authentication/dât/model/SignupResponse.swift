//
//  SignupResponse.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

class SignupDataResponse: Codable {
    var email: String
    var password: String
    var phoneNumber: String
    var name: String
    var deletedDate: Date?
    var isDeleted: Bool?
    var createdAt: String?
    var updatedAt: String?
    var id: String
    
    init(email: String, password: String, phoneNumber: String, name: String, deletedDate: Date?, likeProducts: Any?, isDeleted: Bool, createdAt: String, updatedAt: String, id: String) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.name = name
        self.deletedDate = deletedDate
        self.isDeleted = isDeleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
    }
    
    // Custom decoder to handle the parsing
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.name = try container.decode(String.self, forKey: .name)
        self.deletedDate = try? container.decode(Date.self, forKey: .deletedDate)
        self.isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case phoneNumber
        case name
        case deletedDate
        case isDeleted
        case createdAt
        case updatedAt
        case id
    }
}
