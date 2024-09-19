import SwiftUI

struct PayManagementView: View {
    @Binding var paymentMethods: [PaymentMethodResponseModel]
    @Binding var cards: [PaymentCardResponseModel]
    
    var addCard: () -> Void
    var onSelectCard: (Int) -> Void
    var onSelectMethod: (Int) -> Void
    
    @State private var selectedMethodIndex: Int?;
    @State private var selectedCardIndex: Int?;
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                ForEach(paymentMethods.indices, id: \.self) { index in
                    RadioButtonView(
                        isSelected: selectedMethodIndex == index,
                        label: paymentMethods[index].name
                    )
                    .onTapGesture {
                        self.selectedMethodIndex = index
                        onSelectMethod(index)
                    }
                }
            }.padding(.bottom, 10)
            
            if self.selectedMethodIndex == 0 {
                VStack (alignment: .leading) {
                    ForEach(cards.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(.gray)
                            
                            Text("\(maskCardNumber(cards[index].cardNumber))")
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                self.selectedCardIndex = index
                                
                                onSelectCard(index)
                            }) {
                                Image(
                                    systemName: selectedCardIndex == index 
                                    ? "largecircle.fill.circle"
                                    : "circle"
                                )
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }
                    
                    Button(
                       action: {
                        addCard()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .customFont(size: 18)
                                .foregroundColor(.black)
                            
                            Text("Add New Card")
                                .font(.custom(FontConstants.defautFont, size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                    
                }
            }
        }
        .onChange(of: cards) { oldValue, newValue in
            if (oldValue != newValue) {
                selectedCardIndex = 0;
            } else {
                selectedCardIndex = nil;
            }
        }
        .onChange(of: paymentMethods) { oldValue, newValue in
            if (oldValue != newValue) {
                selectedMethodIndex = 0;
            } else {
                selectedCardIndex = nil;
            }
            
        }
    }
    
    func maskCardNumber(_ cardNumber: String) -> String {
        guard cardNumber.count >= 4 else {
            return cardNumber
        }
        let maskLength = cardNumber.count - 4
        let maskedString = String(repeating: "*", count: maskLength) + cardNumber.suffix(4)
        return maskedString
    }
}

