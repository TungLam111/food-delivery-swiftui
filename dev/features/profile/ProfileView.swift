//
//  ProfileView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel;
    
    var body: some View {
        VStack(
            alignment: .leading
        ){
            ScrollView {
                VStack(
                    alignment: .leading
                ) {
                    CustomAppBar(
                        leadingAction: viewModel.onBack,
                        trailingAction: {},
                        titleCenter: "My profile",
                        canBack: false
                    )
                    
                    Spacer().frame(height: 50)
                    
                    TitleAndInformationView(
                        title: "Information",
                        content: UserInfoView(imageName: "user_avatar", name: "Phan Dam Tung Lam", email: "lamtungphan8@gmail.com", address: "10 Phan Ke Binh")
                    )
                    
                    Spacer().frame(height: 20)
                    
                    
                    TitleAndInformationView(
                        title: "Payment method",
                        content: PaymentMethodSelection()
                    )
                    
                                    
                    Spacer().frame(height: 30)

    
                    // Action button
                    AppActionButton(
                        action: {
                        }, text: "Update")
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                    .padding(.top, 10)
                    
                    Spacer()

                }
                
            }.frame(
                maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .background(ColorConstants.cFFF6F6F9)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
    
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}

struct UserInfoView: View {
    var imageName: String;
    var name: String;
    var email: String;
    var address: String;
    
    var body: some View {
        HStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
    }
}

