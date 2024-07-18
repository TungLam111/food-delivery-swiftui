//
//  HistoryItemView.swift
//  dev
//
//  Created by phan dam tung lam on 18/7/24.
//

import SwiftUI
import URLImage

struct HistoryItemView: View {
    var mealDetail: MealDetail

    var body: some View {
        HStack(alignment: .top) {
            // Leading image of the dish
            
            if let imageUrl = URL(string: mealDetail.strMealThumb ?? "") {
                URLImage(imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing, 10)
                }
            } else {
                VStack {
                    ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            }
                

            // Column with name, price, and category
            VStack(alignment: .leading, spacing: 5) {
                Text(mealDetail.strMeal ?? "")
                    .font(.headline)
                    .lineLimit(1)

                Text(mealDetail.strInstructions ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Text(mealDetail.strCategory ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer() // Pushes content to the leading edge
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(
           mealDetail: MealDetail()
        )
        .previewLayout(.sizeThatFits)
    }
}

