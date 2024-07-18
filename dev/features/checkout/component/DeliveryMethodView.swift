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
        DeliveryOption(iconName: "creditcard", name: "Door delivery", color: .red),
        DeliveryOption(iconName: "banknote", name: "Pick-up", color: .orange)
    ]
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(deliveryOptions) { option in
                DeliveryOptionView(
                    option: option,
                    isSelected: option.id == selectedOption,
                    isLastOption: option.id == deliveryOptions.last?.id
                )
                .onTapGesture {
                    selectedOption = option.id
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
    DeliveryMethodView()
}
