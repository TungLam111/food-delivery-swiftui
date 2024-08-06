
import Foundation


class GetLocationUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute() async throws -> DataState<[LocationResponseModel]?> {
        return try await  self.paymentRepository.getLocations()
    }
}
