//
//  PaymentMethodSelection.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI

struct PaymentOption: Identifiable {
    let id = UUID()
    let iconName: String
    let name: String
    let color: Color
}

struct PaymentMethodSelection: View {
    @State private var selectedOption: UUID?

    let paymentOptions = [
        PaymentOption(iconName: "creditcard", name: "Card", color: .orange),
        PaymentOption(iconName: "banknote", name: "Bank account", color: .pink),
        PaymentOption(iconName: "envelope", name: "Paypal", color: .blue)
    ]

    var body: some View {
        VStack (alignment: .leading) {
            ForEach(paymentOptions) { option in
                PaymentOptionView(
                    option: option,
                    isSelected: option.id == selectedOption,
                    isLastOption: option.id == paymentOptions.last?.id
                )
                    .onTapGesture {
                        selectedOption = option.id
                    }
            }
        }
    }
}

struct PaymentOptionView: View {
    let option: PaymentOption
    let isSelected: Bool
    let isLastOption: Bool

    var body: some View {
        VStack {
            HStack (alignment: .center, spacing: 15) {
                RadioButton(isSelected: isSelected , color: option.color)
                
                Image(systemName: option.iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .background(option.color)
                    .cornerRadius(6)
                
                Text(option.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }.padding(.vertical, 15)
            
            isLastOption ? nil : Divider().frame(height: 1)
        }
    }
}


#Preview {
    PaymentMethodSelection()
}
