//
//  AddPaymentCard.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class VerifyOrderUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(req: VerifyOrderDto) async throws -> DataState<VerifyOrderResponseModel?> {
        return try await  self.paymentRepository.verifyOrder(req: req)
    }
}
