//
//  SwiftUIView.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI

struct NoHistoryView: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.exclamationmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.gray)
            
            Text("No history yet")
                .font(.headline)
                .padding(.top, 16)
            
            Text("Hit the orange button down below to Create an order")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 8)
        }
    }
}

#Preview {
    NoHistoryView()
}
