//
//  ShoppingCartView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct ShoppingCartView: View {
    @StateObject var viewModel: ShoppingCartViewModel;

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ShoppingCartView(
        viewModel: ShoppingCartViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}
