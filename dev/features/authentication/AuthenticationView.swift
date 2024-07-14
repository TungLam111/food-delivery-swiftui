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
            VStack(alignment: .center) {
                Image(AppAsseets.mainIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 162)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
                
                HStack (alignment: .center, spacing: 0) {
                    Button(action: {
                        viewModel.selectedTab = AuthenticationType.login
                    }) {
                        Text(StringConstants.login)
                            .font(StyleConstant.ts18Semibold.font)
                            .fontWeight(StyleConstant.ts18Semibold.weight)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(ColorConstants.cFFFFFFFF)
                            .foregroundColor(ColorConstants.cFF000000)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 0
                                )
                            )
                    }.overlay(
                        Rectangle()
                            .frame(height: viewModel.selectedTab == AuthenticationType.login ? 2 : 0)
                            .foregroundColor(ColorConstants.cFFFA4A0C)
                            .padding(.top, 36),
                        alignment: .bottom
                    )
                    
                    Button(action: {
                        viewModel.selectedTab = AuthenticationType.signup
                    }) {
                        Text(StringConstants.signup)
                            .font(StyleConstant.ts18Semibold.font)
                            .fontWeight(StyleConstant.ts18Semibold.weight)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(ColorConstants.cFFFFFFFF)
                            .foregroundColor(ColorConstants.cFF000000)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 20,
                                    topTrailingRadius: 0
                                )
                            )
                    }
                    .overlay(
                        Rectangle()
                            .frame(height: viewModel.selectedTab == AuthenticationType.signup ? 2 : 0)
                            .foregroundColor(ColorConstants.cFFFA4A0C)
                            .padding(.top, 36),
                        alignment: .bottom
                    )
                }
                
            }
            .frame(maxWidth: .infinity)
            .background(ColorConstants.cFFFFFFFF)
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 30,
                    bottomTrailingRadius: 30,
                    topTrailingRadius: 0
                )
            )
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading) {
                VStack (alignment: .leading) {
                    Text(StringConstants.emailAddress)
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    TextField("", text: $viewModel.email)
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.cFF000000)
                        .padding(.bottom, 10)
                        .onChange(of: viewModel.email, {
                            viewModel.onChangeEmail(email: viewModel.email)
                        })
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(Color.gray), alignment: .bottom)
                }
                
                Spacer().frame(height: 46)
                
                VStack ( alignment: .leading){
                    Text(StringConstants.password)
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5)) //
                    
                    TextField("", text: $viewModel.password)
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.cFF000000)
                        .accentColor(.black)
                        .padding(.bottom, 10)
                        .onChange(of: viewModel.password, {
                            viewModel.onChangePassword(password: viewModel.password)
                        })
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.top, 35)
                                .foregroundColor(Color.gray), alignment: .bottom
                        )
                }
                
                Spacer().frame(height: 34)
                
                Text(StringConstants.forgotPasscode)
                    .font(.custom(FontConstants.defautFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(ColorConstants.cFFFA4A0C)
                    .onTapGesture {
                        print("onTap Forgot passcode")
                    }
                
                HStack(
                    alignment: .center
                ){
                    viewModel.showError ?
                    viewModel.errorMessage != nil && !(viewModel.errorMessage?.isEmpty == true) ?
                    Text(viewModel.errorMessage ?? "")
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.red)
                        .frame(alignment: .center)
                    : nil : nil
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
                
                
                Spacer()
                
                LoginActionButton(
                    action: {
                        print("email \(viewModel.email)")
                        print("password \(viewModel.password)")
                        
                        viewModel.login();
                    },
                    text: viewModel.selectedTab == AuthenticationType.login ? StringConstants.login : StringConstants.signup,
                    isDiable: !viewModel.enableButton,
                    backgroundColor: viewModel.enableButton ? ColorConstants.cFFFA4A0C : Color.gray
                )
                
                Spacer().frame(height: 41)
            }
            .padding(.top, 62)
            .padding(.horizontal, 50)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.cFFF2F2F2)
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
