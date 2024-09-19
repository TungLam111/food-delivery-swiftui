//
//  LoginResponse.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

class LoginDataResponse : Codable {
    var access_token: String;
    var refresh_token: String;
    
    init(access_token: String, refresh_token: String) {
        self.access_token = access_token
        self.refresh_token = refresh_token
    }
}

