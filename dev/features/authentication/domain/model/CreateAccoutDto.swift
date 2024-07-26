//
//  CreateAccoutDto.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

class CreateAccoutDto {
    var email: String;
    var password: String;
    var phoneNumber: String;
    var name: String;
    
    init(email: String, password: String, phoneNumber: String, name: String) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.name = name
    }
    
    func toMap() -> [String: String] {
        var dict = [String: String]()
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let key = child.label, let value = child.value as? String {
                dict[key] = value
            }
        }
        
        return dict
    }
}
