//
//  TitleAndInformationView.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI
import SwiftUI

struct TitleAndInformationView<Content: View, TrailingIcon: View>: View {
    var title: String
    var trailingIcon: TrailingIcon? // Optional view for trailing icon
    var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.custom(FontConstants.defautFont, size: 20))
                    .fontWeight(.medium)
                
                Spacer()
                
                // Conditionally render trailing icon if it exists
                if let icon = trailingIcon {
                    icon
                }
            }
            
            HStack(alignment: .top) {
                content
                    .padding(.bottom, 20)
            }
        }
    }
}
