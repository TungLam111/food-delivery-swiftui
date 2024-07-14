//
//  CustomAppBar.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation
import SwiftUI

struct CustomAppBar: View {
    var leadingAction: () -> Void
    var trailingAction: () -> Void
    
    var body: some View {
        HStack (alignment: .top) {
            Button(action: {
                leadingAction()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 30))
            }
            Spacer()
            Button(action: {
                trailingAction()
            }) {
                Image(systemName: "heart")
                    .foregroundColor(.black)
                    .font(.system(size: 30))
            }
        }
        
    }
}
