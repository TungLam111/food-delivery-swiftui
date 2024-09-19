//
//  AddPaymentCard.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class AddPaymentCardUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(dto: AddPaymentCardDto) async throws -> DataState<PaymentCardResponseModel?> {
        return try await self.paymentRepository.addPaymentCard(dto: dto)
    }
}
