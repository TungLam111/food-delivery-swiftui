//
//  PaymentMethodRadioButtonView.swift
//  dev
//
//  Created by phan dam tung lam on 10/8/24.
//

import Foundation
import SwiftUI

struct RadioButtonView: View {
    let isSelected: Bool
    let label: String
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(
                    isSelected ? ColorConstants.cFF267860 : .gray
                )
            Text(label)
                .font(.custom(FontConstants.defautFont, size: 18))
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
    }
}
