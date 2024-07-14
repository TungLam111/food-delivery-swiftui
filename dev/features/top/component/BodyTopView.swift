//
//  BodyTopView.swift
//  dev
//
//  Created by phan dam tung lam on 10/7/24.
//

import SwiftUI
import URLImage

struct BodyTopView: View {
    @Binding var currentTab: String
    @Binding var categories: [CategoryFoodModel]?
    @Binding var mealsByCategory : [MealModel]?
    var onTapCategory: (String) -> Void
    var onTapDish: (String) -> Void
    var onTapSearchField: () -> Void
    
    init(
        currentTab: Binding<String>,
        categories: Binding<[CategoryFoodModel]?>,
        mealsByCategory: Binding<[MealModel]?>,
        onTapCategory: @escaping (String) -> Void,
        onTapDish: @escaping (String) -> Void,
        onTapSearchField: @escaping () -> Void
    ) {
        self._currentTab = currentTab
        self._categories = categories
        self._mealsByCategory = mealsByCategory
        self.onTapCategory = onTapCategory
        self.onTapDish = onTapDish
        self.onTapSearchField = onTapSearchField
    }
    
    var body: some View {
        VStack {
            SearchBar(
                onTap: {
                    onTapSearchField()
                }
            )
            
            Spacer().frame(height: 40)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(categories ?? []) { item in
                        Text(item.strCategory)
                            .padding()
                            .foregroundColor(ColorConstants.cFFFA4A0C)
                            .cornerRadius(10)
                            .overlay(
                                Rectangle()
                                    .frame(height: currentTab == item.strCategory ? 3 : 0)
                                    .foregroundColor(ColorConstants.cFFFA4A0C)
                                    .padding(.top, 10),
                                alignment: .bottom
                            )
                            .onTapGesture {
                                print("Tapped category: \(item.strCategory)")
                                onTapCategory(item.strCategory)
                            }
                    }
                }
                .padding()
            }
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(mealsByCategory ?? []) { meal in
                        ZStack (
                        ) {
                            // Background dish
                            VStack(alignment: .center, spacing: 0){
                                Spacer().frame(height: 60)
                                Text(meal.strMeal)
                                    .font(.custom(FontConstants.defautFont,size: 22))
                                    .lineLimit(2)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .frame(alignment: .center)
                                Text(String(meal.strMeal))
                                    .font(.custom(FontConstants.defautFont, size: 17))
                                    .fontWeight(.semibold)
                                    .lineLimit(3)
                                    .foregroundColor(ColorConstants.cFFFA4A0C)
                                    .padding()
                                    .frame(alignment: .center)
                            }
                            .frame(width: 220, height: 270)
                            .background(ColorConstants.cFFFFFFFF)
                            .cornerRadius(30)
                            .shadow(radius: 3)
                            
                            // Image dish
                            if let imageUrl = URL(string: meal.strMealThumb) {
                                URLImage(imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 3)
                                        .offset(x: 0, y: -110)
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 3)
                                    .offset(x: 0, y: -110)
                            }
                        }
                        .frame(
                            width : 220,
                            height: 300
                        )
                        .onTapGesture {
                            print("Tapped dish: \(meal.strMeal)")
                            onTapDish(meal.idMeal)
                        }
                        
                    }
                }
                .padding()
            }
            
            
            
        }
    }
}
