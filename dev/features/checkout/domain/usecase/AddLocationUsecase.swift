//
//  AddLocationUsecase.swift
//  dev
//
//  Created by phan dam tung lam on 5/8/24.
//

import Foundation

class AddLocationUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(dto: AddLocationDto) async throws -> DataState<LocationResponseModel?> {
        return try await  self.paymentRepository.addLocation(dto: dto)
    }
}
