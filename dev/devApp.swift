//
//  devApp.swift
//  dev
//
//  Created by phan dam tung lam on 7/7/24.
//

import SwiftUI

@main

struct devApp: App {
    @ObservedObject var rootViewModel = RootViewModel();

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $rootViewModel.navPath) {
                HomeView(viewModel: DependencyInjector.instance.viewModelsDI.home(navigationCoordinator: rootViewModel))
                .navigationDestination(for: RootViewModel.Destination.self) { destination in
                    switch destination {
                    case .landing(let vm):
                        LandingView(viewModel: vm)
                    case .authentication(let vm):
                        AuthenticationView(viewModel: vm)
                    case .home(let vm):
                        HomeView(viewModel: vm)
                    case .history(let vm):
                        HistoryView(viewModel: vm)
                    case .order(let vm):
                        OrderView(viewModel: vm)
                    case .profile(let vm):
                        ProfileView(viewModel: vm)
                    case .search(let vm):
                        SearchView(viewModel: vm)
                    case .dishDetail(let vm):
                        DishDetailView(viewModel: vm)
                    case .checkout(let vm):
                        CheckoutView(viewModel: vm)
                    case .shoppingCart(let vm):
                        ShoppingCartView(viewModel: vm)
                    }
                }
            }
        }
    }
}
