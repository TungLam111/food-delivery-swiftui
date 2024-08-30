//
//  PaymentRepository.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

protocol PaymentRepository {
    func getPaymentMethods() async throws -> DataState<[PaymentMethodResponseModel]?>
    func getPaymentCards() async throws -> DataState<[PaymentCardResponseModel]?>
    func addPaymentCard(dto: AddPaymentCardDto) async throws -> DataState<PaymentCardResponseModel?>
    func removePaymentCard(cardId: String) async throws -> DataState<PaymentCardResponseModel?>
    func getLocations() async throws -> DataState<[LocationResponseModel]?>
    func addLocation(dto: AddLocationDto) async throws -> DataState<LocationResponseModel?>
    func getAllCoupon() async throws -> DataState<[Coupon]?>
    func verifyOrder(req: VerifyOrderDto) async throws -> DataState<VerifyOrderResponseModel?>;
}
