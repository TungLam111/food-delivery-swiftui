//
//  color_constant.swift
//  dev
//
//  Created by phan dam tung lam on 8/7/24.
//

import Foundation
import SwiftUI


struct ColorConstants {
    static let cFFFF4B3A = Color(hex: 0xFF4B3A);
    static let cFFFF460A = Color(hex: 0xFF460A);
    static let cFFFFFFFF = Color(hex: 0xFFFFFF);
    static let cFFFF470B = Color(hex: 0xFF470B);
    static let cFFF2F2F2 = Color(hex: 0xF2F2F2);
    static let cFF000000 = Color(hex: 0x000000);
    static let cFFFA4A0C = Color(hex: 0xFA4A0C);
    static let cFFEFEEEE = Color(hex: 0xEFEEEE);
    static let cFFF6F6F9 = Color(hex: 0xF6F6F9);
    static let cFFC4C4C4 = Color(hex: 0xC4C4C4);
    static let cFFF5F5F8 = Color(hex: 0xF5F5F8);
    static let cFF267860 = Color(hex: 0x267860); // main green
    static let cFF67544A = Color(hex: 0x67544A); // main brown
    static let cFF9D724D = Color(hex: 0x9D724D); // main espresso
    static let cFF2E2E2D = Color(hex: 0x2E2E2D);
    static let cFFFAF8F5 = Color(hex: 0xFAF8F5);
}

struct StringConstants {
    static let foodForEveryone = "Food for \nEveryone";
    static let getStarted = "Get started";
    static let forgotPasscode = "Forgot passcode ?";
    static let login = "Login";
    static let signup = "Signup";
    static let emailAddress = "E-mail";
    static let password = "Password";
}

struct NumberConstants {

}

struct FontConstants {
   static let defautFont = "Kodchasan";
}

struct StyleConstant {
    static let ts65Heavy = TextStyle(weight: Font.Weight.heavy, fontSize: 65);
    static let ts18Semibold = TextStyle(weight: Font.Weight.semibold, fontSize: 18);
}

struct TextStyle {
    let weight: Font.Weight
    let font: Font
    
    init(weight: Font.Weight, fontSize: Int) {
        self.font = Font.custom(FontConstants.defautFont, size: CGFloat(fontSize))
        self.weight = weight
    }
}
