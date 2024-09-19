import Foundation

protocol UserRepository {
    func login(dto: LoginDto) async throws -> DataState<LoginDataResponse?>
    func signup(dto: CreateAccoutDto) async throws -> DataState<SignupDataResponse?>
}
