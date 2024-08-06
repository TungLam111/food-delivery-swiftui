//
//  AddToShoppingBasket.swift
//  dev
//
//  Created by phan dam tung lam on 30/7/24.
//

import Foundation

final class FindOneBasketUsecase {
    private var basketRepository : BasketRepository;
    
    init(basketRepository: BasketRepository) {
        self.basketRepository = basketRepository
    }
    
    func execute(basketId: String) async throws -> DataState<BasketItemResponse?> {
        return try await self.basketRepository.getOne(basketId: basketId);
    }
}
