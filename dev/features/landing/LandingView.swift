//
//  ContentView.swift
//  dev
//
//  Created by phan dam tung lam on 7/7/24.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject var viewModel: LandingViewModel;
    
    var body: some View {
        VStack (alignment: .leading) {
            CircleView(
            imageName: "main_icon"
            )
        
            Text(StringConstants.foodForEveryone)
                .font(Font.custom("SF Pro Rounded Heavy", size: CGFloat(65))) // Closest to 800
                .foregroundColor(ColorConstants.cFFFFFFFF)
                .padding(.leading, 49).lineLimit(2)
            
            ZStack(alignment: .leading) {
                ImageMiddleBoyWidget()
                ImageMiddlGirlWidget()
            }
            
            ActionButton(action: {
                viewModel.navToAuthentication();
            })
                .padding(.horizontal, 50) // Horizontal padding
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 36) // Add horizontal and bottom padding to VStack
        .padding(.top, 10) // Top padding for the entire VStack
        .background(ColorConstants.cFFFF4B3A)
        .navigationBarBackButtonHidden()
    }
}



#Preview {
    LandingView(
        viewModel: LandingViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}
