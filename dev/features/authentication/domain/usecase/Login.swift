//
//  usecase-1.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation

final class LoginUsecase {
    private var userRepository : UserRepository;
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(dto: LoginDto) async throws -> DataState<LoginDataResponse?> {
        return try await self.userRepository.login(dto: dto);
    }
}
