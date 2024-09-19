//
//  File.swift
//  dev
//
//  Created by phan dam tung lam on 1/8/24.
//

import Foundation

class GetBasketListUsecase {
    var basketRepository: BasketRepository;
    init(basketRepository: BasketRepository) {
        self.basketRepository = basketRepository
    }
    
    func execute() async throws -> DataState<BasketListResponse?> {
        return try await self.basketRepository.getAll();
    }
}

class UpdateBasketUsecase {
    
    var basketRepository: BasketRepository;
    init(basketRepository: BasketRepository) {
        self.basketRepository = basketRepository
    }
    
    func execute(dto: UpdateBasketItem) async throws -> DataState<BasketItemResponse?> {
        return try await self.basketRepository.updateBasket(basket: dto);
    }
}

class DeleteBasketUsecase {
    var basketRepository: BasketRepository;
    init(basketRepository: BasketRepository) {
        self.basketRepository = basketRepository
    }
    
    func execute(basketId: String) async throws -> DataState<BasketItemResponse?> {
        return try await self.basketRepository.removeBasket(basketId: basketId)
    }
    
}
