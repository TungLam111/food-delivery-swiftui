//
//  DishDetailView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct DishDetailView: View {
    @StateObject var viewModel: DishDetailViewModel;
    
    var body: some View {
        VStack(
            alignment: .leading
        ){
            ScrollView {
                VStack(
                    alignment: .leading
                ) {
                    CustomAppBar(
                        leadingAction: viewModel.onBack , 
                        trailingAction: viewModel.onFavorite,
                        trailingIcon: CustomImageIconView(iconName: "heart")
                    )
                        .padding(.horizontal, 50)
                    
                    ScrollingImageCarousel(imageUrls: [
                        viewModel.mealDetail?.strMealThumb ?? "",
                        "https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        viewModel.mealDetail?.strMealThumb ?? "",
                        "https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg",
                        viewModel.mealDetail?.strMealThumb ?? "",
                        "https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        viewModel.mealDetail?.strMealThumb ?? "",
                        "https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg",
                        viewModel.mealDetail?.strMealThumb ?? "",
                        "https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                    ])
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
                    
                    Text(viewModel.mealDetail?.strMeal ?? "")
                        .font(.title)
                        .padding(.horizontal, 50)
                        .fontWeight(Font.Weight.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    VStack (alignment: .leading) {
                        Text("Category")
                            .font(.body)
                            .fontWeight(Font.Weight.bold)
                            .padding(.horizontal, 50)
                        
                        Text(viewModel.mealDetail?.strCategory ?? "No categories yet")
                            .font(.body)
                            .padding(.horizontal, 50)
                    }.padding(.vertical, 15)
                    
                    VStack (alignment: .leading) {
                        Text("Tag")
                            .font(.body)
                            .fontWeight(Font.Weight.bold)
                            .padding(.horizontal, 50)
                        
                        Text(viewModel.mealDetail?.strTags ?? "No tags yet")
                            .font(.body)
                            .padding(.horizontal, 50)
                    }
                    .padding(.vertical, 15)
                    
                    VStack (alignment: .leading) {
                        Text("Description")
                            .font(.body)
                            .fontWeight(Font.Weight.bold)
                            .padding(.horizontal, 50)
                        
                        Text(viewModel.mealDetail?.strInstructions ?? "No description yet")
                            .font(.body)
                            .padding(.horizontal, 50)
                    }.padding(.vertical, 15)
                    
                    Spacer()
                }
                
            }.frame(
                maxWidth: .infinity, alignment: .leading)
            
            // Action button
            AppActionButton(
                action: {
                }, text: "Add to cart")
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .background(ColorConstants.cFFF6F6F9)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
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
            argument: DishDetailArgs(id: "52772")
        )
    )
}
