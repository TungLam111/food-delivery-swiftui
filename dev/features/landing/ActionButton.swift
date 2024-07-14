import SwiftUI

struct ActionButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Get started")
                .font(.custom(FontConstants.defautFont, size: 17))
                .fontWeight(.semibold)
                .foregroundColor(ColorConstants.cFFFF460A)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)
        }
    }
}
