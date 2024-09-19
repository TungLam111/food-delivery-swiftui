//
//  BasketRepository.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

protocol BasketRepository {
    func addBasket(basket: AddCartItem) async throws -> DataState<BasketItemResponse?>
    
    func removeBasket(basketId: String) async throws -> DataState<BasketItemResponse?>
    
    func updateBasket(basket: UpdateBasketItem) async throws -> DataState<BasketItemResponse?>
    
    func getAll() async throws -> DataState<BasketListResponse?>
    
    func getOne(basketId: String) async throws -> DataState<BasketItemResponse?>
}
