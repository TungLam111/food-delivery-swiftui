//
//  TitleAndInformationView.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI

struct TitleAndInformationView<Content: View> : View {
    var title: String;
    var content: Content
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.headline)
            
            Spacer().frame(height: 15)
            
            HStack (alignment: .top) {
                content
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(ColorConstants.cFFFFFFFF)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .cornerRadius(30)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

#Preview {
    TitleAndInformationView(title: "Tung Lam ", content: HStack{})
}
