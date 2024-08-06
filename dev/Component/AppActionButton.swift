//
//  ActionButton.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation
import SwiftUI

struct AppActionButton: View {
    var action: () -> Void
    var text: String;
    var isDiable: Bool = false;
    var backgroundColor: Color = ColorConstants.cFFFA4A0C;
    
    var body: some View {
        Button(action: action) {
                Text(text)
                    .font(.custom(FontConstants.defautFont, size: 17))
                    .fontWeight(.medium)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(ColorConstants.cFFFFFFFF)
                    .background(backgroundColor)
                    .cornerRadius(10)
            
        }
        .disabled(isDiable)
    }
}
