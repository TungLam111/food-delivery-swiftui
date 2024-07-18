//
//  TopView.swift
//  dev
//
//  Created by phan dam tung lam on 10/7/24.
//

import SwiftUI

struct TopView: View {
    @StateObject var viewModel: TopViewModel;
    
    var body: some View {
        ZStack (alignment: .bottom) {
            ScrollView(
                
            ){
                HeaderTopView()
                    .padding(.top, 60)
                    .padding(.bottom, 28)
                BodyTopView(
                    currentTab: $viewModel.currentCategory,
                    categories: $viewModel.categories,
                    mealsByCategory: $viewModel.mealsByCategory,
                    onTapCategory:
                        { category in
                            viewModel.findFoodByCategory(category: category)
                        },
                    onTapDish: { dishId in
                        viewModel.navToMealDetail(dishId: dishId);
                    },
                    onTapSearchField: {
                        viewModel.navToSearch();
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(ColorConstants.cFFF2F2F2)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            
            if !viewModel.cartItems.isEmpty {
                VStack {
                    VStack {
                        Text("Xem giỏ hàng")
                            .font(.custom(FontConstants.defautFont, size: 20))
                            .foregroundColor(Color.white)
                    }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(Color.green)
                            .cornerRadius(8)
                }.padding(.bottom, 10)
                    .onTapGesture {
                        viewModel.navToShoppingCart()
                    }
            }
        }
    }
}


#Preview {
    TopView(
        viewModel: TopViewModel(
            navigator: MockNavigationCoordinator(),
            findAllCategoriesUsecase: FindAllCategoriesUsecase(
                foodRepository: FoodRepositoryImpl(remoteDataSource: FoodDataSourceRemote(networkContract: NetworkService()), localDataSource: FoodDataSourceLocal())
            ),
            findFoodByCategoryUsecase: FindFoodByCategoryUsecase(
                foodRepository: FoodRepositoryImpl(remoteDataSource: FoodDataSourceRemote(networkContract: NetworkService()), localDataSource: FoodDataSourceLocal())
            ),
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard)
        )
    )
}
