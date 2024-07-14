//
//  extension.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
