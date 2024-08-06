//
//  FoodItemView.swift
//  dev
//
//  Created by phan dam tung lam on 28/7/24.
//

import SwiftUI
import URLImage

struct FoodItemView: View {
    var meal: MealDetail;
    var onTap: (String) -> Void;
    
    var body: some View {
        ZStack {
            // Background dish
            VStack(alignment: .center, spacing: 0){
                Spacer().frame(height: 60)
                Text(meal.strMeal ?? "")
                    .font(.custom(FontConstants.defautFont,size: 22))
                    .lineLimit(2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(alignment: .center)
                Text(String(meal.strMeal ?? ""))
                    .font(.custom(FontConstants.defautFont, size: 17))
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .foregroundColor(ColorConstants.cFFFA4A0C)
                    .padding()
                    .frame(alignment: .center)
            }
            .frame(width: 220, height: 320)
            .background(ColorConstants.cFFFFFFFF)
            .cornerRadius(30)
            .shadow(radius: 3)
            
            // Image dish
            if let imageUrl = URL(string: meal.strMealThumb ?? "") {
                URLImage(imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 3)
                        .offset(x: 0, y: -110)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                    .offset(x: 0, y: -110)
            }
        }
        .frame(
            width : 220,
            height: 350
        )
        .onTapGesture {
            onTap(meal.idMeal ?? "")
        }
    }
}

#Preview {
    FoodItemView(meal: MealDetail(
    ), onTap: {
        value in
    })
}
