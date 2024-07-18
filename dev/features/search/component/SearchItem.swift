//
//  SearchItem.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import Foundation
import SwiftUI
import URLImage

struct SearchItem : View {
    var meal: MealDetail;
    var width: Float;
    var height: Float;
    var contentHeight: Float;
    
    var imageSize: Float;
    
    var body: some View {
        
        ZStack
        {
            // Background dish
            VStack(alignment: .center, spacing: 0){
                Spacer().frame(height: 100)
                Text(meal.strMeal ?? "")
                    .font(.custom(FontConstants.defautFont,size: 22))
                    .lineLimit(2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(alignment: .center)
                Text(meal.strMeal ?? "")
                    .font(.custom(FontConstants.defautFont, size: 17))
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .foregroundColor(ColorConstants.cFFFA4A0C)
                    .padding()
                    .frame(alignment: .center)
            }
            .frame(width: CGFloat(width), height: CGFloat(contentHeight))
            .background(ColorConstants.cFFFFFFFF)
            .cornerRadius(30)
            .shadow(radius: 3)
            
            // Image dish
            if let imageUrl = URL(string: meal.strMealThumb ?? "") {
                URLImage(imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: CGFloat(imageSize), height: CGFloat(imageSize))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 3)
                        .offset(x: 0, y: -90)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: CGFloat(imageSize), height: CGFloat(imageSize))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                    .offset(x: 0, y: -90)
            }
        }
        .frame(
            width : CGFloat(width),
            height: CGFloat(height)
        )
        .onTapGesture {
            print("Tapped dish: \(String(describing: meal.strMeal))")
        }
    }
}

