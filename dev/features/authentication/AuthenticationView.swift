//
//  AuthenticationPage.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

struct AuthenticationView: View {
    
    @StateObject var viewModel : AuthenticationViewModel;
    
    var body: some View {
        VStack {
            Spacer()
            
            // Top Logo Image
            Image("authentication_coffee_bean") // Replace with your actual image asset name
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Spacer().frame(height: 20)
            
            // Welcome Text
            Text("Welcome to Coff!")
                .customFont(size: 30, weight: .bold)
                .foregroundColor(.black)
            
            Spacer().frame(height: 20)

            Text("Let's Get Started")
                .customFont(size: 20, weight: .regular)
            
            Spacer().frame(height: 20)
            
            // Log In Button
            Button(action: {
                // Log in action
                viewModel.navLogin()
            }) {
                Text("Log In")
                    .customFont(size: 20, weight: .regular)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(ColorConstants.cFF267860)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer().frame(height: 20)
            
            // Sign Up Button
            Button(action: {
                // Sign up action
                viewModel.navSignup()
            }) {
                Text("Sign Up")
                    .customFont(size: 20, weight: .regular)
                    .foregroundColor(ColorConstants.cFF267860)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(ColorConstants.cFF267860, lineWidth: 2)
                    )
            }
            .padding(.horizontal)
            
            Spacer().frame(height: 30)
            
            // Or Connect With
            Text(". . . Or Connect With . . .")
                .customFont(size: 20, weight: .regular)
            
            Spacer().frame(height: 30)
            
            HStack(spacing: 20) {
                Button(action: {
                    // Facebook action
                    viewModel.connectFacebook()
                }) {
                    Image(systemName: "f.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.indigo)
                }
                
                Button(action: {
                    // Google action
                    viewModel.connectGoogle()
                }) {
                    Image(systemName: "g.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
            
            // Bottom Coffee Cup Image
            VStack {
                Image("authentication_coffee") // Replace with your actual image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            Spacer()
        }
        .padding(.vertical, 40)
        .background(Color(UIColor.systemGray6))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}


#Preview {
    AuthenticationView(
        viewModel: AuthenticationViewModel(
            navigator: MockNavigationCoordinator(), argument: nil
        )
    )
}
