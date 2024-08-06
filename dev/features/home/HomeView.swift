//
//  HomeView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel : HomeViewModel;
    
    var body: some View {
        VStack () {
            TabView {
                TopView(
                    viewModel:
                        DependencyInjector
                        .instance
                        .viewModelsDI
                        .top(navigationCoordinator: viewModel.navigator)
                )
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                HistoryView(
                    viewModel: DependencyInjector.instance.viewModelsDI.history(navigationCoordinator: viewModel.navigator)
                )
                .tabItem {
                    Image(systemName: "clock.fill")
                    
                    Text("History")
                }
                
                OrderView(
                    viewModel: DependencyInjector.instance.viewModelsDI.order(navigationCoordinator: viewModel.navigator)
                )
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Orders")
                }
                
                ProfileView(
                    viewModel: DependencyInjector.instance.viewModelsDI.profile(navigationCoordinator: viewModel.navigator)
                )
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
            }.accentColor(ColorConstants.cFFFA4A0C)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.cFFF2F2F2)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}


#Preview {
    HomeView(
        viewModel: DependencyInjector.instance.viewModelsDI.home(navigationCoordinator: RootViewModel())
    )
}
