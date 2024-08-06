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
    @Binding var mealsByCategory : [MealDetail]?
    var onTapCategory: (String) -> Void
    var onTapDish: (String) -> Void
    
    init(
        currentTab: Binding<String>,
        categories: Binding<[CategoryFoodModel]?>,
        mealsByCategory: Binding<[MealDetail]?>,
        onTapCategory: @escaping (String) -> Void,
        onTapDish: @escaping (String) -> Void
    ) {
        self._currentTab = currentTab
        self._categories = categories
        self._mealsByCategory = mealsByCategory
        self.onTapCategory = onTapCategory
        self.onTapDish = onTapDish
    }
    
    var body: some View {
        VStack {            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(categories ?? []) { item in
                        Text(item.strCategory)
                            .font(.custom(FontConstants.defautFont, size: 17))
                            .fontWeight(.medium)
                            .padding()
                            .foregroundColor(
                                currentTab == item.strCategory ? .white : ColorConstants.cFF2E2E2D
                            )
                            .background(
                                currentTab == item.strCategory ? ColorConstants.cFF2E2E2D : .white
                            )
                            .cornerRadius(5)
                            .shadow(radius: 2)
                            .onTapGesture {
                                print("Tapped category: \(item.strCategory)")
                                onTapCategory(item.strCategory)
                            }
                    }
                }
            }
            .padding(.bottom, 20)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 16
                ) {
                    ForEach(mealsByCategory ?? []) { meal in
                        CoffeeItemView(meal: meal, onTap: { value in
                            onTapDish(value)
                        } )
                        
                    }
                }
            }
            
        }.padding(.horizontal, 16)
    }
}
