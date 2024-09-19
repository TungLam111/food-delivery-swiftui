//
//  HeaderTopView.swift
//  dev
//
//  Created by phan dam tung lam on 10/7/24.
//

import SwiftUI

struct HeaderTopView: View {
    var onTapShoppingCart: () -> Void;
    var onTapSearchField: () -> Void;
    var onTapNotification: () -> Void;

    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 68)
                
                Spacer()
                Text("Home")
                    .font(.custom(FontConstants.defautFont, size: 25))
                    .foregroundColor(ColorConstants.cFFFFFFFF)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "cart")
                    .font(.custom(FontConstants.defautFont, size: 24))
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        onTapShoppingCart()
                    }
                
                Spacer().frame(width: CGFloat(20.0))
                
                Image(systemName: "bell")
                    .font(.custom(FontConstants.defautFont, size: 24))
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        onTapNotification()
                    }
            }
            SearchBarView (
                onTap: {
                    onTapSearchField()
                }
            )
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(ColorConstants.cFF2E2E2D)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HeaderTopView(
        onTapShoppingCart: {},
        onTapSearchField: {},
        onTapNotification: {}
    )
}
