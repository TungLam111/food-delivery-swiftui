import SwiftUI

struct CardManagementView: View {
    @Binding var cards: [PaymentCardResponseModel]
    var addCard: () -> Void

    @State private var selectedIndex: Int?;

    var body: some View {
        VStack (alignment: .leading) {
            ForEach(cards.indices, id: \.self) { index in
                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.gray)
                    
                    Text("\(maskCardNumber(cards[index].cardNumber))")
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                            selectedIndex = index
                    }) {
                        Image(systemName: selectedIndex == index ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
            }

            Button(action: {
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
        .onChange(of: cards) { oldValue, newValue in
            if (oldValue != newValue) {
                selectedIndex = 0;
            } else {
                selectedIndex = nil;
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
