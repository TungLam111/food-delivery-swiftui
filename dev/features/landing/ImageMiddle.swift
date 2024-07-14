//
//  image_middle.swift
//  dev
//
//  Created by phan dam tung lam on 8/7/24.
//

import SwiftUI

struct ImageMiddlGirlWidget: View {
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .bottom)
        ) {
            Image(AppAsseets.landingGirl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .padding(.leading, -82)
                .frame(height: 400)
            
            LinearGradient(
                gradient: Gradient(
                    colors:
                        [
                            ColorConstants.cFFFF470B.opacity(1.0),
                            ColorConstants.cFFFF470B.opacity(0.1),
                        ]
                ),
                startPoint: .bottom,
                endPoint: .top
            ).frame(maxHeight: 195)
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 500
        )
    }
}


struct ImageMiddleBoyWidget: View {
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .trailing,
                vertical: .bottom
            )
        ) {
            Image(AppAsseets.landingBoy)
                .resizable()
                .aspectRatio(contentMode: .fit )
                .edgesIgnoringSafeArea(.all)
                .padding(.trailing, -50)
                .frame(height: 300)
            LinearGradient(
                gradient:
                    Gradient(
                        colors:
                            [
                                ColorConstants.cFFFF470B.opacity(1.0),
                                ColorConstants.cFFFF470B.opacity(0.1),
                            ]
                    ),
                startPoint: .bottom,
                endPoint: .top
            ).frame(maxHeight: 170)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 450
        )
    }
}


