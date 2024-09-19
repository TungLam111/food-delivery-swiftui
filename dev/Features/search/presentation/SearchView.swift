//
//  SearchView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI
import URLImage

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel;
    
    var body: some View {
        ScrollView() {
            VStack() {
                HStack {
                    Button(action: {
                        viewModel.onBack();
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    TextField("Search", text: $viewModel.searchText)
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 10)
                        .onChange(of: viewModel.searchText, {
                            viewModel.onSearching(text: viewModel.searchText)
                        })
                        .background(ColorConstants.cFFF5F5F8)
                }
                .padding(.horizontal, 50)
                .padding(.top, 40)
                
                Text("Found \(viewModel.mealsByCategory.count) results")
                    .frame(alignment: .center)
                    .font(.custom(FontConstants.defautFont, size: 25))
                    .fontWeight(Font.Weight.bold)
                
                // List Results
                VStack (alignment: .leading, spacing: 0) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(170), spacing: 20),
                        GridItem(.fixed(170), spacing: 20)],
                              
                              alignment: .center) {
                        ForEach(viewModel.mealsByCategory, id: \.self) { meal in
                            if viewModel.mealsByCategory.firstIndex(of: meal)! % 2 == 0 {
                                
                                SearchItem(meal: meal,
                                           width: 170,
                                           height: 300,
                                           contentHeight: 270,
                                           imageSize: 130
                                ).padding(.top, viewModel.mealsByCategory.count == 1 ? 20 : 0)
                                
                            } else {
                                VStack {
                        
                                    SearchItem(meal: meal,
                                               width: 170,
                                               height: 300,
                                               contentHeight: 270 ,
                                               imageSize: 130
                                               
                                    ).padding(.top, 30)
                                }
                            }
                        }
                    }
                              .clipShape(
                                .rect(
                                    topLeadingRadius: 30,
                                    topTrailingRadius: 30
                                )
                              )
                    
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(ColorConstants.cFFF5F5F8)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    SearchView(
        viewModel: SearchViewModel(
            navigator: MockNavigationCoordinator(),
            searchByTextUsecase: SearchByTextUsecase(
                foodRepository: FoodRepositoryImpl(
                    remoteDataSource: FoodDataSourceRemote(networkContract: NetworkService()),
                    localDataSource: FoodDataSourceLocal()))
        )
    )
}
