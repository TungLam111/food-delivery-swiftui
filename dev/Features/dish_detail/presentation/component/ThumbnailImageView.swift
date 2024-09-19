//
//  ThumbnailImageView.swift
//  dev
//
//  Created by phan dam tung lam on 2/8/24.
//

import SwiftUI
import URLImage

struct ThumbnailImageView: View {
    @Binding var strMealThumb : MealDetail?;
    
    init(strMealThumb: Binding<MealDetail?>) {
        self._strMealThumb = strMealThumb
    }
    
    var body: some View {
        VStack {
            if let imageUrl = URL(string: self.strMealThumb?.strMealThumb ?? "") {
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
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}
