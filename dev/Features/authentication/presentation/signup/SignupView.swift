//
//  AuthenticationPage.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

struct SignupView: View {
    
    @StateObject var viewModel : SignupViewModel;
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .onTapGesture {
                        viewModel.onBack()
                    }
                
                Spacer()
                
                Text("Sign Up")
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(.black)
            .cornerRadius(10)
            
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Full Name")
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        
                        TextField("Type your name & surname", text: $viewModel.name)
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(ColorConstants.cFF000000)
                            .padding(.vertical, 10)
                            .accentColor(.black)
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
                    Text(StringConstants.emailAddress)
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        
                        TextField("Type your e-mail", text: $viewModel.email)
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(ColorConstants.cFF000000)
                            .padding(.vertical, 10)
                            .accentColor(.black)
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
                    Text("Phone number")
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.gray)
                        
                        TextField("Type your phone number", text: $viewModel.phone)
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(ColorConstants.cFF000000)
                            .padding(.vertical, 10)
                            .accentColor(.black)
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
                    Text("Create password")
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        
                        if viewModel.isPasswordVisible {
                            TextField("Type your password", text: $viewModel.password)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
                        } else {
                            SecureField("Type your password", text: $viewModel.password)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
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
                
                Spacer().frame(height: 30)
                
                VStack (alignment: .leading) {
                    Text("Repeat password")
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray.opacity(0.5)) //
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        
                        if viewModel.isRepeatPasswordVisible {
                            TextField("Retype password above", text: $viewModel.repeatPassword)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
                            
                        } else {
                            SecureField("Retype password above", text: $viewModel.password)
                                .font(.custom(FontConstants.defautFont, size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(ColorConstants.cFF000000)
                                .accentColor(.black)
                                .padding(.vertical, 10)
                            
                        }
                        
                        Button(action: {
                            viewModel.isRepeatPasswordVisible.toggle()
                        }) {
                            Image(systemName: viewModel.isRepeatPasswordVisible ? "eye.slash" : "eye")
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
            }
            
            VStack {
                viewModel.showError ?
                viewModel.errorMessage != nil && !(viewModel.errorMessage?.isEmpty == true) ?
                Text(viewModel.errorMessage ?? "")
                    .font(.custom(FontConstants.defautFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
                    .frame(alignment: .center)
                : nil : nil
                
                HStack {
                    Spacer()
                    
                    Toggle(isOn: $viewModel.acceptTerm) {
                        Text("I argee to Terms and Conditions?")
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                }
            }.padding(.top, 10)
            
            AppActionButton(
                action: {
                    viewModel.singup();
                },
                text: "Create Account",
                isDiable: !viewModel.acceptTerm,
                backgroundColor: viewModel.acceptTerm ? ColorConstants.cFF267860 : Color.gray
            )
        }
        .padding(.top, 60)
        .padding(.bottom, 30)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.cFFF2F2F2)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    SignupView(
        viewModel: SignupViewModel(
            navigator: MockNavigationCoordinator(), 
            argument: nil, 
            createAccountUsecase: CreateAccountUsecase(userRepository: UserRepositoryImpl(
                remoteDataSource: UserDataSourceRemote(networkContract: NetworkService(),
                                                       authenticationLocalStorage: AuthenticationLocalStorage(defaults: UserDefaults.standard)
                                                      ),
                localDataSource: UserDataSourceLocal()
            ))
        )
    )
}
