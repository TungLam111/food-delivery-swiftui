//
//  AddPaymentCardDto.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

final class AddLocationDto : Encodable {
    var address: String
    var name: String
    var latitude: Double
    var longitude: Double
    var ggPlaceId: String
    
    init(address: String, name: String, latitude: Double, longitude: Double, ggPlaceId: String) {
        self.address = address
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.ggPlaceId = ggPlaceId
    }
}
