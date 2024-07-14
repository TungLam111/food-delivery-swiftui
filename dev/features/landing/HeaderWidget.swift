//
//  HeaderWidget.swift
//  dev
//
//  Created by phan dam tung lam on 8/7/24.
//

import SwiftUI

struct CircleView: View {
    var imageName: String // Image name from Assets
    
    var body: some View {
        ZStack(
            content: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 73, height: 73)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 50) // Adj
            }
        ).padding(.leading, 49)
    }
}
