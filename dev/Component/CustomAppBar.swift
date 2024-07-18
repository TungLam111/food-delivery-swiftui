//
//  CustomAppBar.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation
import SwiftUI

struct CustomImageIconView : View {
    var iconName: String;
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(.black)
            .font(.system(size: 30))
    }
}

struct CustomAppBar: View {
    var leadingAction: () -> Void?
    var trailingAction: () -> Void?
    var titleCenter: String?
    var trailingIcon: CustomImageIconView?
    var canBack: Bool? = true
    
    var body: some View {
        HStack (alignment: .top) {
            if canBack == true {
                Button(action: {
                    leadingAction()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                }
            }
            
            Spacer()
            
            titleCenter != nil ? Text(titleCenter ?? "")
                .font(.custom(FontConstants.defautFont, size: CGFloat(22)))
                .fontWeight(Font.Weight.semibold)
            : nil
            
            Spacer()
            
            
            trailingIcon != nil ?
            Button(action: {
                trailingAction()
            }) {
                trailingIcon
            } : nil
        }
        
    }
}
