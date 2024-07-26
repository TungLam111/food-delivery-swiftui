//
//  LoginDto.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

struct LoginDto {
    var email: String;
    var password: String;
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
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
