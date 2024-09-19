//
//  ToppingView.swift
//  dev
//
//  Created by phan dam tung lam on 30/7/24.
//

import SwiftUI

struct ToppingView: View {
    var titleTopping: String;
    @Binding var initialToppingOption: Int?;
    var toppingOptions: [String];
    var onTapOption: (Int) -> Void;
    
    @State var selectedOption : Int;
    
    init(titleTopping: String, initialToppingOption: Binding<Int?>, toppingOptions: [String], onTapOption: @escaping (Int) -> Void) {
        self.titleTopping = titleTopping
        self._initialToppingOption = initialToppingOption
        self.toppingOptions = toppingOptions
        self.onTapOption = onTapOption
        self.selectedOption = initialToppingOption.wrappedValue ?? 0;
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(titleTopping)
                .font(.custom(FontConstants.defautFont, size: 20))
                .fontWeight(.medium)
            
            Spacer().frame(height: 8)
            
            HStack  {
                ForEach(Array(toppingOptions.enumerated()), id: \.1) { index, item in
                    
                    HStack {
                        RadioButton(isSelected: selectedOption == index,
                                    color: ColorConstants.cFF267860
                        )
                        
                        Text("\(item)")
                            .font(.custom(FontConstants.defautFont, size: 20))
                            .fontWeight(.medium)
                            .padding(.horizontal, 5)
                    }.onTapGesture {
                        selectedOption = index;
                        onTapOption(index)
                    }
                }
            }
        }.frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.bottom, 15)
        .onChange(of: initialToppingOption) { oldValue, newValue in
            if (oldValue != newValue) {
                self.selectedOption = newValue ?? self.selectedOption;
            }
        }
    }
}
