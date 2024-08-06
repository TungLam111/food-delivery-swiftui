//
//  BaseView.swift
//  dev
//
//  Created by phan dam tung lam on 29/7/24.
//

import Foundation
import SwiftUI

struct BaseView<Content: View> : View {
    var mainContent: Content;
    @Binding var mainLoadingStatus: Bool;
    var onAppear: () -> Void;
    
    var body: some View {
        ZStack {
            mainContent
            if mainLoadingStatus {
                LoadingOverlay()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear(perform: {
            onAppear();
        })
    }
}
