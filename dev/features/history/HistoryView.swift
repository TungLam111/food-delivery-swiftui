//
//  HistoryView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel;
    
    var body: some View {
        VStack(
            alignment: .leading
        ){
            ScrollView {
                VStack(
                    alignment: .leading
                ) {
                    CustomAppBar(
                        leadingAction: viewModel.onBack,
                        trailingAction: {},
                        titleCenter: "History",
                        canBack: false
                    )
                    
                    Spacer().frame(height: 20)
                    
                    ForEach(viewModel.historyItems) { item in
                        HistoryItemView(mealDetail: item )
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)  // Hide row separator
                            .background(Color.clear)
                            .onTapGesture {
                                viewModel.navToMealDetail(dishId: item.idMeal ?? "")
                            }
                    }
                }
            }.frame(
                maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .background(ColorConstants.cFFF6F6F9)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    HistoryView(
        viewModel: HistoryViewModel(
            navigator: MockNavigationCoordinator(),
            searchByTextUsecase: SearchByTextUsecase(foodRepository: FoodRepositoryImpl(
                remoteDataSource: FoodDataSourceRemote(networkContract: NetworkService()),
                localDataSource: FoodDataSourceLocal()
            )
                                                     
            )
        )
    )
}
