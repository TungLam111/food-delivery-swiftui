import Foundation

final class CreateAccountUsecase {
    private var userRepository : UserRepository;
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(dto: CreateAccoutDto) async throws -> DataState<SignupDataResponse?> {
        return try await self.userRepository.signup(dto: dto);
    }
}
