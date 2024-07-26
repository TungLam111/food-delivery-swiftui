//
//  UserRepository.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

protocol UserRepository {
    func login(dto: LoginDto) async throws -> DataState<LoginDataResponse?>
    func signup(dto: CreateAccoutDto) async throws -> DataState<SignupDataResponse?>
}
