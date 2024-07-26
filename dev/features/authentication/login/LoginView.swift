//
//  AuthenticationPage.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel : LoginViewModel;
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            viewModel.onBack()
                        }
                    Spacer()
                    
                    Text("Log in")
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(.black)
                .cornerRadius(10)
                
                Spacer().frame(height: 30)
                
                VStack (alignment: .leading) {
                    Text(StringConstants.emailAddress)
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        
                        TextField("", text: $viewModel.email)
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(ColorConstants.cFF000000)
                            .padding(.vertical, 10)
                            .onChange(of: viewModel.email, {
                                viewModel.onChangeEmail(email: viewModel.email)
                            })
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                }
                
                Spacer().frame(height: 30)
                
                VStack (alignment: .leading) {
                    Text(StringConstants.password)
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5)) //
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        
                        if viewModel.isPasswordVisible {
                            TextField("", text: $viewModel.password)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
                                .onChange(of: viewModel.password, {
                                    viewModel.onChangePassword(password: viewModel.password)
                                })
                        } else {
                            SecureField("", text: $viewModel.password)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
                                .onChange(of: viewModel.password, {
                                    viewModel.onChangePassword(password: viewModel.password)
                                })
                        }
                        
                        
                        
                        Button(action: {
                            viewModel.isPasswordVisible.toggle()
                        }) {
                            Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                }
                
                HStack(
                    alignment: .top
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
                
                Spacer().frame(height: 41)
                
                HStack {
                    Toggle(isOn: $viewModel.rememberMe) {
                        Text("Remember me")
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        // Forgot password action
                    }) {
                        Text("Forgot password?")
                            .foregroundColor(ColorConstants.cFF267860)
                    }
                }
                .padding(.bottom, 20)
                
                AppActionButton(
                    action: {
                        print("email \(viewModel.email)")
                        print("password \(viewModel.password)")
                        
                        viewModel.login();
                    },
                    
                    text: StringConstants.login,
                    isDiable: !viewModel.enableButton,
                    backgroundColor: viewModel.enableButton ? ColorConstants.cFF267860 : Color.gray
                )
                
                
                Spacer()
                    .frame(height: 40)
                
                HStack {
                    Spacer()
                    Text("Don't have an account?")
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        viewModel.navToSignup();
                    }) {
                        Text("Sign Up")
                            .fontWeight(.medium)
                            .foregroundColor(Color(.white))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            .padding(.top, 62)
            .padding(.horizontal, 20)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.cFFF2F2F2)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? Color(ColorConstants.cFF267860) : Color.secondary)
                .onTapGesture { configuration.isOn.toggle()
                    
                }
            configuration.label
        }
    }
}


#Preview {
    LoginView(
        viewModel: LoginViewModel(
            navigator: MockNavigationCoordinator(), argument: nil, loginUsecase: LoginUsecase(userRepository: UserRepositoryImpl(remoteDataSource: UserDataSourceRemote(networkContract: NetworkService()), localDataSource: UserDataSourceLocal() )
                                                                    )
        ))
}
