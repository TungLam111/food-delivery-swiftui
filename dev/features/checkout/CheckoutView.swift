//
//  ProfileView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct CheckoutView: View {
    @StateObject var viewModel: CheckoutViewModel;
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack(
                alignment: .leading
            ){
                ScrollView {
                    VStack(
                        alignment: .leading
                    ) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .onTapGesture {
                                    viewModel.onBack()
                                }
                            
                            Spacer()
                            
                            Text("Checkout")
                                .font(.custom(FontConstants.defautFont, size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(ColorConstants.cFF2E2E2D)
                        .cornerRadius(10)
                        
                        Spacer().frame(height: 20)
                        
                        TitleAndInformationView(
                            title: "Payment Details",
                            trailingIcon: TrailingEditIconView(
                                onTap: {
                                    
                                }),
                            content: CardManagementView(
                                cards: $viewModel.paymentCards,
                                addCard: viewModel
                                    .addCard
                            )
                        ).frame(maxWidth: .infinity)
                        
                        TitleAndInformationView(
                            title: "Shipping Information",
                            trailingIcon: TrailingEditIconView(
                                onTap: {
                                    
                                }),
                            content: AddressView(
                                addresses: $viewModel.addresses,
                                addAddress: viewModel.addAddress
                            )
                        )
                        
                        TitleAndInformationView(
                            title: "Promocode",
                            trailingIcon: TrailingEditIconView(
                                onTap: {
                                    
                                }),
                            content: VStack(
                                content: {
                                    HStack {
                                        TextField("Enter your promocode", text: $viewModel.promocode)
                                            .font(.custom(FontConstants.defautFont, size: 17))
                                            .fontWeight(.medium)
                                            .fontWeight(.bold)
                                            .foregroundColor(ColorConstants.cFF000000)
                                            .padding(.vertical, 10)
                                            .accentColor(.black)
                                        
                                        Image(systemName: "person")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 15)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle")
                                            .foregroundColor(.gray)
                                        
                                        Text("The promo discount will be applied to card total sum")
                                            .font(.custom(FontConstants.defautFont, size: 15))
                                            .fontWeight(.medium)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 5)
                                    
                                })
                        )
                        
                        Spacer().frame(height: 200)
                    }
                    
                }.frame(
                    maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 60)
            .background(ColorConstants.cFFF2F2F2)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Total")
                        .font(.custom(FontConstants.defautFont, size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("$100")
                        .font(.custom(FontConstants.defautFont, size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }.padding(.horizontal, 20)
                    .padding(.top, 10)
                
                AppActionButton(
                    action: {
                        viewModel.processToPayment()
                    },
                    text: "Pay",
                    backgroundColor: ColorConstants.cFF267860
                )
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .cornerRadius(20)
            }
            .background(ColorConstants.cFF2E2E2D)
            .frame(maxWidth: .infinity)
            
            if viewModel.isAllowToShow {
                CustomDialogView(
                    isPresented: $viewModel.isAllowToShow)
                .transition(.opacity)
                .zIndex(1)
            }
            
            if viewModel.showBottomSheet {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            viewModel.showBottomSheet = false
                        }
                    }
                    .zIndex(1) // Ensure the background overlay is below the bottom sheet
                
                PaymentBottomSheetView(
                    isPresented: $viewModel.showBottomSheet,
                    confirmPay: viewModel.confirmPay
                )
                    .transition(.move(edge: .bottom))
                    .zIndex(2)
            }
        }
    }
}

#Preview {
    CheckoutView(
        viewModel: DependencyInjector.instance.viewModelsDI.checkout(navigationCoordinator: RootViewModel())
    )
}

struct AddressDetalInfo: View {
    var imageName: String;
    var name: String;
    var phoneNumber: String;
    var address: String;
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Divider()
                
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text(phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
    }
}

