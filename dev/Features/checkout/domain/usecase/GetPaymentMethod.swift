//
//  GetPaymentMethod.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class GetPaymentMethodUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute() async throws -> DataState<[PaymentMethodResponseModel]? > {
        return try await self.paymentRepository.getPaymentMethods()
    }
}
