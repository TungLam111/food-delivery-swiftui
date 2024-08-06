//
//  CartItemView.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI
import URLImage

struct CartItemView: View {
    @Binding var item: BasketItemResponse;
    var onAdd : () -> Void;
    var onSubtract : () -> Void;
    
    var body: some View {
        VStack{
            HStack {
                
                if let imageUrl = URL(string: item.mealImage) {
                    URLImage(imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.trailing, 10)
                    }
                } else {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                }
                
                
                VStack(alignment: .leading) {
                    Text(item.mealName)
                        .font(.custom(FontConstants.defautFont, size: 20))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .foregroundColor(.white)
                    
                    Text(item.mealCategory)
                        .font(.custom(FontConstants.defautFont, size: 18))
                        .lineLimit(1)
                        .foregroundColor(.white)
                    
                    VStack (alignment: .leading, spacing: 0) {
                        ForEach(Array(item.topping), id: \.key) { key, value in
                            Text("\(key): \(value)")
                                .font(.custom(FontConstants.defautFont, size: 18))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("$\(item.price)")
                        .font(.custom(FontConstants.defautFont, size: 18))
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                    }) {
                        Text("-")
                            .foregroundColor(.white)
                            .onTapGesture {
                                if item.quantity > 0 {
                                    onSubtract();
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(ColorConstants.cFF267860)
                            .cornerRadius(5)
                    }
                    
                    Text("\(String(describing: item.quantity))")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        
                    }) {
                        Text("+")
                            .foregroundColor(.white)
                            .onTapGesture {
                                onAdd();
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(ColorConstants.cFF267860)
                            .cornerRadius(5)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            .background(ColorConstants.cFF2E2E2D)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 10
                )
            )
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
        
    }
}


struct SwipeableView: View {
    @Binding var item: BasketItemResponse
    let onRemove: () -> Void
    var onAdd : () -> Void;
    var onSubtract : () -> Void;
    var onTapItem: () -> Void;
    var onDetectVerticalScroll: (CGSize) -> Void;
    
    @State private var offset: CGFloat = 0
    @State private var markOffset: CGFloat = 0
    
    init(
        onRemove: @escaping () -> Void,
        item: Binding<BasketItemResponse>,
        onAddItem: @escaping () -> Void,
        onSubtractItem: @escaping () -> Void,
        onTapItem: @escaping () -> Void,
        onDetectVerticalScroll: @escaping (CGSize) -> Void
    ) {
        self.onRemove = onRemove
        self._item = item
        self.onAdd = onAddItem;
        self.onSubtract = onSubtractItem;
        self.onTapItem = onTapItem;
        self.onDetectVerticalScroll = onDetectVerticalScroll;
    }
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    VStack {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 50)
                    .frame(width: 100)
                    .onTapGesture {
                        onRemove()
                        withAnimation {
                            self.markOffset = 0
                            self.offset = 0
                        }
                    }
                }
            }.background(ColorConstants.cFF800000)
            
            CartItemView(
                item: self.$item,
                onAdd: self.onAdd ,
                onSubtract: self.onSubtract
            ).offset(x: offset)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 20, coordinateSpace: .local)
                        .onChanged { gesture in
                            if (gesture.translation.width <= 0) || (markOffset == -100 && gesture.translation.width > 0) {
                                self.offset = markOffset + gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            withAnimation {
                                if self.offset <= -100 {
                                    self.offset = -100
                                    self.markOffset = -100
                                } else {
                                    self.offset = 0
                                    self.markOffset = 0
                                }
                            }
                        }
                )
                .background(
                    Rectangle()
                        .fill(Color.clear)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    onDetectVerticalScroll(value.translation)
                                }
                                .onEnded { _ in
                                    onDetectVerticalScroll(.zero)
                                }
                        )
                    
                )
        }.background(ColorConstants.cFFF6F6F9)
            .onTapGesture {
                onTapItem()
            }
            .padding(.bottom, 10)
    }
}

