//
//  ShoppingCartView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct CartItem: Identifiable, Decodable, Encodable {
    var id = UUID()
    let imageName: String
    let name: String
    let price: String
    var quantity: Int
}

struct ShoppingCartView: View {
    
    @StateObject var viewModel: ShoppingCartViewModel;
    
    
    var body: some View {
        VStack (
            alignment: .leading
        ) {
            
            CustomAppBar(
                leadingAction: viewModel.onBack,
                trailingAction: {},
                titleCenter: "Delivery"
            )
            
            Spacer().frame(height: 30)
            
            HStack (alignment: .center) {
                Spacer()
                Image(systemName: "hand.draw")
                    .foregroundColor(.black)
                
                Text("swipe on an item to delete")
                    .font(.footnote)
                    .padding(.top)
                Spacer()
            }.frame(alignment:.center)
            
            List {
                ForEach($viewModel.cartItems) { $item in
                    SwipeableView(
                        onRemove: {
                            viewModel.onRemove(item: item);
                        },
                        item: $item,
                        onAddItem: {id in
                            viewModel.onAdd(id: id);
                        },
                        onSubtractItem: {id in
                            viewModel.onSubtract(id: id);
                        },
                        onDetectVerticalScroll: { cgSize in
                            viewModel.verticalOffsetScrolling = cgSize;
                        }
                    )
                    .offset(x: viewModel.verticalOffsetScrolling.width, y: 0)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)  // Hide row separator
                    .background(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .padding(.horizontal, 10)
            
            
            // Action button
            AppActionButton(
                action: {
                }, text: "Complete Order")
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
            .padding(.top, 10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .padding(.horizontal, 20)
        .background(ColorConstants.cFFF6F6F9)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    ShoppingCartView(
        viewModel: ShoppingCartViewModel(
            navigator: MockNavigationCoordinator(),
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard)
        )
    )
}

