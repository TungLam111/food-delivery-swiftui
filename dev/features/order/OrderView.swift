//
//  OrderView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel;

    var body: some View {
        Text("Order")
    }
}

#Preview {
    OrderView(
        viewModel: OrderViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}
