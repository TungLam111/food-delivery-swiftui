//
//  TopView.swift
//  dev
//
//  Created by phan dam tung lam on 10/7/24.
//

import SwiftUI

struct TopView : View {    
    @StateObject var viewModel: TopViewModel;
    
    func CouponColor(couponType: CouponType) -> Color {
        if couponType == CouponType.gift {
            return ColorConstants.cFF267860
        }
        else if couponType == CouponType.sale {
            return ColorConstants.cFF67544A
        }
        return ColorConstants.cFF9D724D
    }
    
    var body: some View {
        BaseView(
            mainContent:  {
                ZStack (alignment: .bottom) {
                    ScrollView {
                        HeaderTopView(
                            onTapShoppingCart: {
                                viewModel.navToShoppingCart()
                            },
                            onTapSearchField: {
                                viewModel.navToSearch()
                            },
                            onTapNotification: {}
                        )
                        .padding(.top, 60)
                        
                        Spacer().frame(height: 16)
                        
                        ScrollingImageCarousel(
                            currentPage: $viewModel.currentCouponIndex,
                            data:
                                self.viewModel.couponList,
                            onChange: { index in
                                self.viewModel.currentCouponIndex = index
                            },
                            itemCount: self.viewModel.couponList.count,
                            itemBuilder: { idx in
                                return VStack(alignment: .leading, spacing: 10) {
                                    Text(self.viewModel.couponList[idx].name)
                                        .font(.custom(FontConstants.defautFont, size: 30))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text(
                                        AppHelper.parseDate(dateToParse: self.viewModel.couponList[idx].timeEnd))
                                    .font(.custom(FontConstants.defautFont, size: 20))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    
                                    Text(self.viewModel.couponList[idx].content)
                                        .font(.custom(FontConstants.defautFont, size: 20))
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .background(CouponColor(couponType: self.viewModel.couponList[idx].type))
                                .cornerRadius(CGFloat(10))
                                .padding(.horizontal, 16)
                            },
                            carouselHeight: 120
                        )
                        .frame(
                            maxWidth: .infinity
                        )
                        
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
                            }
                        )
                        .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(ColorConstants.cFFFFFFFF)
                    .navigationBarBackButtonHidden()
                    .ignoresSafeArea()
                    
                    if !viewModel.cartItems.isEmpty {
                        VStack {
                            VStack {
                                Text("Basket")
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
            }(),
            mainLoadingStatus: $viewModel.mainLoadingStatus,
            onAppear: {
                viewModel.getSavedShoppingCarts()
            }
        )
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

