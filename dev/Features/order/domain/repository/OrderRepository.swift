//
//  PaymentRepository.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

protocol OrderRepository {
    func getOrders() async throws -> DataState<[OrderResponseModel]?>
    func getOrder(orderId: String) async throws -> DataState<OrderResponseModel?>
    func cancelOrder(orderId: String) async throws -> DataState<OrderResponseModel?>
    func createOrder(dto: PayDto) async throws -> DataState<OrderResponseModel?>
}
