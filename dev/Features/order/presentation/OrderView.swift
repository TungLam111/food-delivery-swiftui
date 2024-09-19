//
//  OrderView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI
import URLImage


struct OrderView: View {
    @StateObject var viewModel: OrderViewModel;
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CustomAppBar(
                    leadingAction: viewModel.onBack,
                    trailingAction: {},
                    titleCenter: "Orders",
                    canBack: false
                )
                
                Spacer().frame(height: 20)
                
                ForEach($viewModel.orders, id: \.self) { $order in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Order Number: \(order.orderNumber)")
                            .font(.title3)
                            .bold()
                        
                        ForEach($order.dishes, id: \.idMeal) { $dish in
                            HStack(alignment: .top) {
                                // Leading network image of the dish
                                if let imageUrl = URL(string: dish.strMealThumb ?? "") {
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
                                
                                // Column with name, price, and quantity
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(dish.strMeal ?? "Unknown Dish")
                                        .font(.headline)
                                        .lineLimit(1)
                                    
                                    Text(dish.price ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("Quantity: \(String(describing: dish.quantity))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer() // Pushes content to the leading edge
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                            .onTapGesture {
                                viewModel.navToMealDetail(dishId: dish.idMeal ?? "");
                            }
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .background(ColorConstants.cFFF6F6F9)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}
