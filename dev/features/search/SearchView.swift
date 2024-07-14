//
//  SearchView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel;
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchView(
        viewModel: SearchViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}
