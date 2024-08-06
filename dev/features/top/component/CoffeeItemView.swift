//
//  CoffeeItemView.swift
//  dev
//
//  Created by phan dam tung lam on 28/7/24.
//

import SwiftUI
import URLImage

struct CoffeeItemView:  View {
    var meal: MealDetail;
    var onTap: (String) -> Void;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                VStack {
                    Spacer()

                    Text("20% \noff")
                        .font(.custom(FontConstants.defautFont, size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                    
                    Spacer()
                }
                .background(ColorConstants.cFF67544A)
                .cornerRadius(5)
                .frame(maxHeight: 120)
                
                Spacer()
                
                if let imageUrl = URL(string: meal.strMealThumb ?? "") {
                    URLImage(imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(5)
                            .frame(width: 120, height: 120)
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(5)
                        .frame(width: 120, height: 120)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            
            Spacer().frame(height: 10)
            
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Text(meal.strMeal ?? "")
                        .font(.custom(FontConstants.defautFont,size: 22))
                        .lineLimit(1)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                    
                    Text(String(meal.strMeal ?? ""))
                        .font(.custom(FontConstants.defautFont, size: 17))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                }.padding(5)
                
                Spacer()
            }
            .background(ColorConstants.cFF9D724D)
            .cornerRadius(5)
            
            HStack {
                Text(meal.price ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(ColorConstants.cFF267860)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 10)
        }
        .padding(10)
        .background(ColorConstants.cFF2E2E2D)
        .frame(maxWidth: (UIScreen.main.bounds.width - 48) * 0.5)
        .cornerRadius(10)
        .shadow(radius: 3)
        .onTapGesture {
            onTap(meal.idMeal ?? "")
        }
    }
}
