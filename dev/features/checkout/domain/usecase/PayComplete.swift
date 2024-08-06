//
//  PayComplete.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class PaymentCompleteUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(dto: PayDto) async throws -> DataState<PayCompleteResponseModel?> {
        return try await self.paymentRepository.pay(dto: dto)
    }
}
