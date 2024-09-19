//
//  CustomFontExtension.swift
//  dev
//
//  Created by phan dam tung lam on 21/7/24.
//

import Foundation
import SwiftUI

struct CustomFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(.custom(FontConstants.defautFont, size: size).weight(weight))
    }
}

extension View {
    func customFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(CustomFontModifier(size: size, weight: weight))
    }
}
