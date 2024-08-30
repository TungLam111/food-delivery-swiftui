//
//  PayComplete.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class PaymentCompleteUsecase {
    private var orderRepository : OrderRepository;
    
    init(orderRepository: OrderRepository) {
        self.orderRepository = orderRepository
    }
    
    func execute(dto: PayDto) async throws -> DataState<OrderResponseModel?> {
        return try await self.orderRepository.createOrder(dto: dto)
    }
}
