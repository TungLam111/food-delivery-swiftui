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
        ZStack {
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
                            titleCenter: "Checkout"
                            
                        )
                        
                        Spacer().frame(height: 50)
                        
                        viewModel.checkoutPhase == "delivery" ?
                        Text("Delivery")
                            .font(.custom(FontConstants.defautFont, size: CGFloat(40)))
                        :
                        Text("Payment")
                            .font(.custom(FontConstants.defautFont, size: CGFloat(40)))
                        
                        Spacer().frame(height: 20)
                        
                        if viewModel.checkoutPhase == "delivery" {
                            TitleAndInformationView(
                                title: "Address details",
                                content: AddressDetalInfo(
                                    imageName: "user_avatar",
                                    name: "Phan Dam Tung Lam",
                                    phoneNumber: "(+84) 829976232",
                                    address: "10 Phan Ke Binh"
                                )
                            )
                        } else {
                            TitleAndInformationView(
                                title: "Payment method",
                                content: PaymentMethodSelection()
                            )
                        }
                        
                        Spacer().frame(height: 20)
                        
                        TitleAndInformationView(
                            title: "Delivery method",
                            content: DeliveryMethodView()
                        )
                        
                        Spacer()
                    }
                    
                }.frame(
                    maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                HStack() {
                    Text("Total")
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .fontWeight(Font.Weight.regular)
                    
                    Spacer()
                    Text("23.000")
                        .font(.custom(FontConstants.defautFont, size: 22))
                        .fontWeight(Font.Weight.bold)
                }
                .padding(.horizontal, 30)
                
                Spacer().frame(height: 20)
                
                // Action button
                AppActionButton(
                    action: {
                        viewModel.processToPayment()
                    }, text: "Proceed to payment"
                )
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 60)
            .background(ColorConstants.cFFF6F6F9)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            
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
                
                BottomSheetView(isPresented: $viewModel.showBottomSheet)
                    .transition(.move(edge: .bottom))
                    .zIndex(2) // Ensure the bottom sheet is on top
            }
        }
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            navigator: MockNavigationCoordinator()
        )
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

