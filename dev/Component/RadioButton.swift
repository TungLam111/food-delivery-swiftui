//
//  RadioButton.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI

struct RadioButton: View {
    var isSelected: Bool
    var color: Color = .orange

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(color, lineWidth: 2)
                .frame(width: 24, height: 24)
            
            if isSelected {
                Circle()
                    .fill(color)
                    .frame(width: 12, height: 12)
            }
        }
    }
}
