import SwiftUI

struct SearchBarView: View {
    var onTap: () -> Void
    
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 20)
            
            TextField("Search for anything", text: $searchText)
                .font(.custom(FontConstants.defautFont, size: 15))
                .fontWeight(.medium)
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                .disabled(true)
            
            Image(systemName: "mic")
                .foregroundColor(.gray)
                .padding(.trailing, 20)
        }
        .background(ColorConstants.cFFEFEEEE)
        .cornerRadius(10)
        .onTapGesture {
            onTap();
        }
    }
}

