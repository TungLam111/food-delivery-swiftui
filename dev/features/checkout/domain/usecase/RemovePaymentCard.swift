//
//  RemovePaymentCard.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation


class RemovePaymentCardUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(cardId: String) async throws -> DataState<PaymentCardResponseModel?> {
        return try await  self.paymentRepository.removePaymentCard(cardId: cardId)
    }
}
