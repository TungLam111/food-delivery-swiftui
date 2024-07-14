//
//  HeaderTopView.swift
//  dev
//
//  Created by phan dam tung lam on 10/7/24.
//

import SwiftUI

struct HeaderTopView: View {
    var body: some View {
        VStack(
            alignment: .leading
        ){
            HStack(){
                Image(systemName: "line.horizontal.3")
                    .font(.custom(FontConstants.defautFont, size: 24))
                Spacer()
                Image(systemName: "cart")
                    .font(.custom(FontConstants.defautFont, size: 24))
            }.padding(.horizontal, 40 )
            
            Spacer().frame(height: 43)
            
            Text("Delicious\nfood for you")
                .font(.custom(FontConstants.defautFont, size: 34))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
        }
    }
}

#Preview {
    HeaderTopView()
}
