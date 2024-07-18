//
//  CustomPopupView.swift
//  dev
//
//  Created by phan dam tung lam on 17/7/24.
//

import Foundation
import SwiftUI

struct CustomDialogView: View {
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background to handle tap to close
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                // Dialog content
                VStack(spacing: 20) {
                    Text("Please note")
                        .font(.title2)
                        .bold()
                    
                    VStack(spacing: 10) {
                        Text("DELIVERY TO MAINLAND")
                            .font(.subheadline)
                            .bold()
                        Text("N1000 - N2000")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    
                    Divider()
                    
                    VStack(spacing: 10) {
                        Text("DELIVERY TO ISLAND")
                            .font(.subheadline)
                            .bold()
                        Text("N2000 - N3000")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }.onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            withAnimation {
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
                            // Add your action here
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
                }
                .padding()
                .background(Color.white) // Set your desired background color here
                .cornerRadius(20)
                .shadow(radius: 10)
                .frame(width: geometry.size.width * 0.8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .onTapGesture {
                    
                }
            }
        }
    }
}
