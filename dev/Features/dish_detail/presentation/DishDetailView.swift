//
//  DishDetailView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI
import URLImage

struct DishDetailView: View {
    @StateObject var viewModel: DishDetailViewModel;
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack(
                alignment: .leading
            ){
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            viewModel.onBack()
                        }
                    
                    Spacer()
                    
                    Text("Product")
                        .font(.custom(FontConstants.defautFont, size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(ColorConstants.cFF2E2E2D)
                .cornerRadius(10)
                
                ScrollView {
                    VStack(
                        alignment: .leading
                    ) {
                        
                        ThumbnailImageView(
                            strMealThumb: $viewModel.mealDetail
                        )
                        
                        HStack (alignment: .top) {
                            Text(viewModel.mealDetail?.strMeal ?? "")
                                .font(.custom(FontConstants.defautFont, size: 30))
                                .fontWeight(Font.Weight.medium)
                            
                            Text(viewModel.mealDetail?.strCategory ?? "")
                                .font(.custom(FontConstants.defautFont, size: 30))
                                .fontWeight(Font.Weight.medium)
                            
                        }
                        
                        Spacer().frame(height: 10)
                        
                        VStack {
                            ForEach(viewModel.toppings.indices, id: \.self) { i in
                                ToppingView(
                                    titleTopping: viewModel.toppings[i].name,
                                    initialToppingOption: $viewModel.toppingSelection[viewModel.toppings[i].type],
                                    
                                    toppingOptions: viewModel.toppings[i].options,
                                    
                                    onTapOption: { idx in
                                        viewModel.onUpdateOption(type: viewModel.toppings[i].type, idx: idx)
                                    }
                                )
                            }
                        }
                        
                        Text(viewModel.mealDetail?.strInstructions ?? "")
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(Font.Weight.medium)
                            .padding(.vertical, 10)
                        
                        Spacer().frame(height: 200)
                    }
                }.frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            }
            .padding(.top, 60)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(ColorConstants.cFFF2F2F2)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            
            
            VStack {
                HStack {
                    Text("Price")
                        .font(.custom(FontConstants.defautFont, size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(viewModel.mealDetail?.price ?? "")
                        .font(.custom(FontConstants.defautFont, size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }.padding(.horizontal, 20)
                    .padding(.top, 10)
                
                AppActionButton(
                    action: {
                        viewModel.addToCart()
                    },
                    text: "Add to basket",
                    backgroundColor: ColorConstants.cFF267860
                )
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .cornerRadius(20)
            }
            .background(ColorConstants.cFF2E2E2D)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    DishDetailView(
        viewModel: DishDetailViewModel(
            navigator: MockNavigationCoordinator(),
            findMealDetailUsecase: FindMealDetailUsecase(
                foodRepository: FoodRepositoryImpl(
                    remoteDataSource: FoodDataSourceRemote(networkContract: NetworkService()),
                    localDataSource: FoodDataSourceLocal())),
            addToShoppingBasketUsecase: AddToShoppingBasketUsecase(
                basketRepository: BasketRepositoryImpl(
                    remoteDataSource: BasketDataSourceRemote(
                        networkContract: NetworkService(
                        ),
                        authenticationLocalStorage: AuthenticationLocalStorage(defaults: UserDefaults.standard)
                        
                    ),
                    
                    localDataSource: BasketDataSourceLocal())
            ),
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard), 
            findOneBasketUsecase: FindOneBasketUsecase(basketRepository: BasketRepositoryImpl(
                remoteDataSource: BasketDataSourceRemote(
                    networkContract: NetworkService(
                    ),
                    authenticationLocalStorage: AuthenticationLocalStorage(defaults: UserDefaults.standard)
                    
                ),
                
                localDataSource: BasketDataSourceLocal())),
            argument: DishDetailArgs(id: "52772", basketId: nil)
        )
    )
}
