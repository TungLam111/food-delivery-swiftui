import SwiftUI

struct SearchBar: View {
    var onTap: () -> Void
    
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 20)
            
            TextField("Search", text: $searchText)
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                .disabled(true)
        }
        .background(ColorConstants.cFFEFEEEE)
        .cornerRadius(30)
        .padding(.horizontal, 50)
        .onTapGesture {
            onTap();
        }
    }
}

