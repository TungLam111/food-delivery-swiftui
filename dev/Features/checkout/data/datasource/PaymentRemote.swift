import Foundation
import Combine


protocol PaymentDataSourceRemoteContract: DataSourceRemoteContract {
    func getPaymentMethods() async throws -> CommonResponse<[PaymentMethodResponseModel]>?
    func getPaymentCards() async throws -> CommonResponse<[PaymentCardResponseModel]>?
    func addPaymentCard(dto: AddPaymentCardDto) async throws -> CommonResponse<PaymentCardResponseModel>?
    func pay(dto: PayDto) async throws -> CommonResponse<OrderResponseModel>?
    func removePaymentCard(cardId: String) async throws -> CommonResponse<PaymentCardResponseModel>?
    func getLocations() async throws -> CommonResponse<[LocationResponseModel]>?;
    func addLocation(dto: AddLocationDto) async throws -> CommonResponse<LocationResponseModel>?;
    func getAllCoupons() async throws -> CommonResponse<[Coupon]>?;
    func verifyCoupon(req: VerifyOrderDto ) async throws -> CommonResponse<VerifyOrderResponseModel>?
}

final class PaymentDataSourceRemote : PaymentDataSourceRemoteContract {

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
    
    func addLocation(dto: AddLocationDto) async throws -> CommonResponse<LocationResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.location,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<LocationResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "POST"
        );
    }
    
    
    func getLocations() async throws -> CommonResponse<[LocationResponseModel]>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.location,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<[LocationResponseModel]>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        );
    }
    
    func getPaymentMethods() async throws -> CommonResponse<[PaymentMethodResponseModel]>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.paymentMethod,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<[PaymentMethodResponseModel]>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        );
    }
    
    func getPaymentCards() async throws -> CommonResponse<[PaymentCardResponseModel]>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.paymentCard,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<[PaymentCardResponseModel]>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        );
    }
    
    func addPaymentCard(dto: AddPaymentCardDto) async throws -> CommonResponse<PaymentCardResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.paymentCard,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<PaymentCardResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "POST"
        );
    }
    
    func pay(dto: PayDto) async throws -> CommonResponse<OrderResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.order,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<OrderResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "POST"
        );
    }
    
    func removePaymentCard(cardId: String) async throws -> CommonResponse<PaymentCardResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.paymentCardOne.replacingOccurrences(of: "id", with: cardId),
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<PaymentCardResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "DELETE"
        );
    }
    
    func getAllCoupons() async throws -> CommonResponse<[Coupon]>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.coupon,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<[Coupon]>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        );
    }
    
    func verifyCoupon(req: VerifyOrderDto) async throws -> CommonResponse<VerifyOrderResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.checkOrder,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<VerifyOrderResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: req,
            method: "POST"
        );
    }
    
    
}
