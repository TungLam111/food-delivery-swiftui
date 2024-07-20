//
//  CartItemView.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import SwiftUI
import URLImage

struct CartItemView: View {
    @Binding var item: CartItem;
    var onAdd : (String) -> Void;
    var onSubtract : (String) -> Void;
    
    var body: some View {
        VStack{
            HStack {
                
                if let imageUrl = URL(string: item.imageName) {
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
                    Text(item.name)
                        .font(.headline)
                    
                    Text(item.price)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                HStack(spacing: 10) {
                    Button(action: {
                    }) {
                        Text("-")
                            .foregroundColor(.white)
                            .onTapGesture {
                                if item.quantity > 0 {
                                    onSubtract(item.id);
                                }
                            }
                    }
                    
                    Text("\(item.quantity)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        
                    }) {
                        Text("+")
                            .foregroundColor(.white)
                            .onTapGesture {
                                onAdd(item.id);
                            }
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(ColorConstants.cFFFA4A0C)
                .cornerRadius(30)
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            .background(Color.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10, topTrailingRadius: 10
                )
            )
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
        
    }
}


struct SwipeableView: View {
    @Binding var item: CartItem
    let onRemove: () -> Void
    var onAdd : (String) -> Void;
    var onSubtract : (String) -> Void;
    var onDetectVerticalScroll: (CGSize) -> Void;
    
    @State private var offset: CGFloat = 0
    @State private var markOffset: CGFloat = 0
    
    init(onRemove: @escaping () -> Void,
         item: Binding<CartItem>,
         onAddItem: @escaping (String) -> Void,
         onSubtractItem: @escaping (String) -> Void,
         onDetectVerticalScroll: @escaping (CGSize) -> Void
    ) {
        self.onRemove = onRemove
        self._item = item
        self.onAdd = onAddItem;
        self.onSubtract = onSubtractItem;
        self.onDetectVerticalScroll = onDetectVerticalScroll;
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 40, height: 40)
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(width: 100)
                        .onTapGesture {
                            onRemove()
                            withAnimation {
                                self.markOffset = 0
                                self.offset = 0
                            }
                        }
                    }
                }.background(ColorConstants.cFFF6F6F9)
                
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
            
            Spacer().frame(height: 10)
        }.background(ColorConstants.cFFF6F6F9)
    }
}

