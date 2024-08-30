//
//  enums.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation


enum AuthenticationType {
    case login
    case signup
}

enum HomeTab {
       case top, heart, user, history
}

enum CouponType {
    case sale
    case freeShip
    case gift
}

enum OrderType {
    case ship
    case take_away
    case reserve
    
    var string: String {
        switch self {
        case .ship:
            return "ship"
        case .take_away:
            return "take_away"
        default:
            return "reserve"
        }
    }
}


enum CardType {
    case visa, mastercard, amex, discover

    var prefix: String {
        switch self {
        case .visa:
            return "4"
        case .mastercard:
            return ["51", "52", "53", "54", "55"].randomElement()!
        case .amex:
            return ["34", "37"].randomElement()!
        case .discover:
            return "6011"
        }
    }
    
    var toString: String {
        switch self {
        case .visa:
            return "visa"
        case .mastercard:
            return "mastercard"
        case .amex:
            return "amex"
        case .discover:
            return "discover"
        }
    }

    var length: Int {
        switch self {
        case .visa, .mastercard, .discover:
            return 16
        case .amex:
            return 15
        }
    }
}

