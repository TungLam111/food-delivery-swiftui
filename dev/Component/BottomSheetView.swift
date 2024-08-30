//
//  BottomSheetView.swift
//  dev
//
//  Created by phan dam tung lam on 17/7/24.
//

import Foundation
import SwiftUI

struct PaymentBottomSheetView: View {
    @Binding var isPresented: Bool
    var confirmPay: () -> Void;
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Spacer()
                    
                    Text("Please note")
                        .font(.title2)
                        .bold()
                    
                    Spacer().frame(height: 20)
                    
                    VStack(spacing: 10) {
                        Text("DELIVERY TO MAINLAND")
                            .font(.subheadline)
                            .bold()
                        Text("N1000 - N2000")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    
                    Spacer().frame(height: 20)
                    
                    Divider()
                    
                    Spacer().frame(height: 20)
                    
                    VStack(spacing: 10) {
                        Text("DELIVERY TO ISLAND")
                            .font(.subheadline)
                            .bold()
                        Text("N2000 - N3000")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
                                isPresented = false
                            }
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            isPresented = false
                            confirmPay()
                        }) {
                            Text("Proceed")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(ColorConstants.cFFFA4A0C)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(10)
                .background(Color.white)
                .shadow(radius: 10)
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4 )
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height > 100 {
                                withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
                                    isPresented = false
                                }
                            }
                        }
                )
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height - geometry.size.height * 0.2)
        }
    }
}
