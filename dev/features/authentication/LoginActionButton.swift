//
//  ActionButton.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct LoginActionButton: View {
    var action: () -> Void
    var text: String;
    var isDiable: Bool = false;
    var backgroundColor: Color = ColorConstants.cFFFA4A0C;

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom(FontConstants.defautFont, size: 17))
                .fontWeight(.semibold)
                .foregroundColor(ColorConstants.cFFFFFFFF)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(30)
                .padding(.horizontal, 20)
        }
        .disabled(isDiable)
    }
}
