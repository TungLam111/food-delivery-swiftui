//
//  AddToShoppingBasket.swift
//  dev
//
//  Created by phan dam tung lam on 30/7/24.
//

import Foundation

final class AddToShoppingBasketUsecase {
    private var basketRepository : BasketRepository;
    
    init(basketRepository: BasketRepository) {
        self.basketRepository = basketRepository
    }
    
    func execute(basket: AddCartItem) async throws -> DataState<BasketItemResponse?> {
        return try await self.basketRepository.addBasket(basket: basket);
    }
}
