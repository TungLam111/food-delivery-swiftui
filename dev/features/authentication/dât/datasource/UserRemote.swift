import Foundation
import Combine

protocol UserDataSourceRemoteContract {
    func login(dto: LoginDto) async throws -> CommonResponse<LoginDataResponse>?;
    func signup(dto: CreateAccoutDto) async throws -> CommonResponse<SignupDataResponse>?;
}

final class UserDataSourceRemote : UserDataSourceRemoteContract {
    
    private var networkContract: NetworkServiceContract;
    
    init(networkContract: NetworkServiceContract) {
        self.networkContract = networkContract
    }
    
    func login(dto: LoginDto) async throws -> CommonResponse<LoginDataResponse>? {
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.loginUrl,
            headers: nil,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<LoginDataResponse>?.self,
            customUrl: formEndpoint.urlMain,
            body: dto.toMap(),
            method: "POST"
        );
    }
    
    func signup(dto: CreateAccoutDto) async throws -> CommonResponse<SignupDataResponse>? {
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.signupUrl,
            headers: nil,
            queries: nil
        )
                    
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<SignupDataResponse>?.self,
            customUrl: formEndpoint.urlMain,
            body: dto.toMap(),
            method: "POST"
        );
    }
}
