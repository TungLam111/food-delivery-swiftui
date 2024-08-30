//
//  GetListCoupon.swift
//  dev
//
//  Created by phan dam tung lam on 10/8/24.
//

import Foundation

final class GetListCouponUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute() async throws -> DataState<[Coupon]?> {
        return try await self.paymentRepository.getAllCoupon();
    }
}
