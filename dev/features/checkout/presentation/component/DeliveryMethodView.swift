import SwiftUI

struct DeliveryOption: Identifiable {
    let id = UUID()
    let iconName: String
    let name: String
    let color: Color
}

struct DeliveryMethodView: View {
    @State private var selectedOption: UUID?
    
    let deliveryOptions = [
        DeliveryOption(
            iconName: "creditcard",
            name: "Credicard",
            color: ColorConstants.cFF267860
        ),
        DeliveryOption(
            iconName: "banknote",
            name: "Cash On Delivery",
            color: ColorConstants.cFF267860
        )
    ]
    
    var body: some View {
        HStack (alignment: .center) {
            ForEach(deliveryOptions.indices,  id: \.self) { idx in
                    DeliveryOptionView(
                        option: deliveryOptions[idx],
                        isSelected: deliveryOptions[idx].id == selectedOption,
                        isLastOption: deliveryOptions[idx].id == deliveryOptions.last?.id
                    )
                .onTapGesture {
                    selectedOption = deliveryOptions[idx].id
                }
            }
        }
    }
}

struct DeliveryOptionView: View {
    let option: DeliveryOption
    let isSelected: Bool
    let isLastOption: Bool
    
    var body: some View {
            HStack (spacing: 10) {
                RadioButton(isSelected: isSelected , color: option.color)
                
                Text(option.name)
                    .font(.custom(FontConstants.defautFont, size: 18))
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            }.padding(.bottom, 15)
            .padding(.trailing, 10)
        }
}

struct TrailingEditIconView : View {
    var onTap: () -> Void
    
    var body: some View {
        Image(systemName: "pencil.and.outline")
            .foregroundColor(.black)
            .font(.system(size: 20))
            .onTapGesture {
                onTap()
            }
    }
}


#Preview {
    DeliveryMethodView()
}
