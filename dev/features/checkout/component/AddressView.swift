//
//  AddressView.swift
//  dev
//
//  Created by phan dam tung lam on 3/8/24.
//

import SwiftUI

import SwiftUI

struct AddressView: View {
    @Binding var addresses: [LocationResponseModel]
    var addAddress: () -> Void;

    @State private var selectedAddressIndex : Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(addresses.indices, id: \.self) { index in
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            self.selectedAddressIndex = index
                        }
                    
                    Text(addresses[index].address)
                        .font(.custom(FontConstants.defautFont, size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: selectedAddressIndex == index ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            self.selectedAddressIndex = index
                        }
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
            }
            
            Button(action: addAddress) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                    
                    Text("Add New Address")
                        .font(.custom(FontConstants.defautFont, size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
        .onChange(of: addresses) { oldValue, newValue in
            if oldValue != newValue {
                selectedAddressIndex = 0
            } else {
                selectedAddressIndex = nil
            }
        }
    }
}
