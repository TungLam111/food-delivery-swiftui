//
//  ShoppingCartView.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @StateObject var viewModel: ShoppingCartViewModel;
    
    var body: some View {
        BaseView(
            mainContent: ZStack (alignment: .bottom) {
                VStack (
                    alignment: .leading
                ) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .onTapGesture {
                                viewModel.onBack()
                            }
                        
                        Spacer()
                        
                        Text("Basket")
                            .font(.custom(FontConstants.defautFont, size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(ColorConstants.cFF2E2E2D)
                    .cornerRadius(10)
                    
                    Spacer().frame(height: 30)
                    
                    List {
                        ForEach($viewModel.cartItems) { $item in
                            SwipeableView(
                                onRemove: {
                                    viewModel.onRemove(item: item);
                                },
                                item: $item,
                                onAddItem: {
                                    viewModel.onAdd(id: item.id);
                                },
                                onSubtractItem: {
                                    viewModel.onSubtract(id: item.id);
                                },
                                onTapItem : {
                                    viewModel.onTap(dish: item)
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
                    
                    Spacer().frame(height: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 60)
                .padding(.horizontal, 20)
                .background(ColorConstants.cFFF6F6F9)
                .navigationBarBackButtonHidden()
                .ignoresSafeArea()
                
                
                
                VStack {
                    HStack {
                        Text("Card total")
                            .font(.custom(FontConstants.defautFont, size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("$\(String(viewModel.basketPricingData?.foodPrice ?? 0))")
                            .font(.custom(FontConstants.defautFont, size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }.padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    AppActionButton(
                        action: {
                            viewModel.buyNow()
                        },
                        text: "Buy now",
                        backgroundColor: ColorConstants.cFF267860
                    )
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .cornerRadius(20)
                }
                .background(ColorConstants.cFF2E2E2D)
                .frame(maxWidth: .infinity)
                
            },
            
            mainLoadingStatus: $viewModel.mainLoadingStatus,
            onAppear: {
                viewModel.getSavedShoppingCarts()
            }
        )
        
    }
}

#Preview {
    ShoppingCartView(
        viewModel: DependencyInjector.instance.viewModelsDI.shoppingCart(navigationCoordinator: RootViewModel())
    )
}


