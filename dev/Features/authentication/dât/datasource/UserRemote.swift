import Foundation
import Combine


protocol UserDataSourceRemoteContract: DataSourceRemoteContract {
    func login(dto: LoginDto) async throws -> CommonResponse<LoginDataResponse>?;
    func signup(dto: CreateAccoutDto) async throws -> CommonResponse<SignupDataResponse>?;
}

final class UserDataSourceRemote : UserDataSourceRemoteContract {
    private var networkContract: NetworkServiceContract;
    private var authenticationLocalStorage: AuthenticationLocalStorage;
    
    func getAuthorizationStorage() -> AuthenticationLocalStorage {
        return self.authenticationLocalStorage;
    }
    
    init(
        networkContract: NetworkServiceContract,
        authenticationLocalStorage: AuthenticationLocalStorage
    ) {
        self.networkContract = networkContract
        self.authenticationLocalStorage = authenticationLocalStorage
    }
    
    func login(dto: LoginDto) async throws -> CommonResponse<LoginDataResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.loginUrl,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<LoginDataResponse>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto.toMap(),
            method: "POST"
        );
    }
    
    func signup(dto: CreateAccoutDto) async throws -> CommonResponse<SignupDataResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.signupUrl,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<SignupDataResponse>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto.toMap(),
            method: "POST"
        );
    }
}
