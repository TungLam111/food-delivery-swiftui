import Foundation
import SwiftUI

class CheckoutViewModel: BaseViewModel {
    private let navigator: NavigationCoordinator;
    private let getPaymentMethodsUsecase : GetPaymentMethodUsecase;
    private let getPaymentCardsUsecase : GetPaymentCardsUsecase;
    private let addPaymentCardUsecase : AddPaymentCardUsecase;
    private let payCompleteUsecase : PaymentCompleteUsecase;
    private let removePaymentCardUsecase : RemovePaymentCardUsecase;
    private let getLocationsUsecase: GetLocationUsecase;
    private let addLocationUsecase: AddLocationUsecase;
    private let verifyOrderUsecase: VerifyOrderUsecase;
    
    init(
        navigator: NavigationCoordinator,
        getPaymentMethodsUsecase: GetPaymentMethodUsecase,
        getPaymentCardsUsecase: GetPaymentCardsUsecase,
        addPaymentCardUsecase: AddPaymentCardUsecase,
        payCompleteUsecase: PaymentCompleteUsecase,
        removePaymentCardUsecase: RemovePaymentCardUsecase,
        getLocationsUsecase: GetLocationUsecase,
        addLocationUsecase: AddLocationUsecase,
        verifyOrderUsecase: VerifyOrderUsecase
    ) {
        self.navigator = navigator
        self.getPaymentMethodsUsecase = getPaymentMethodsUsecase
        self.getPaymentCardsUsecase = getPaymentCardsUsecase
        self.addPaymentCardUsecase = addPaymentCardUsecase
        self.payCompleteUsecase = payCompleteUsecase
        self.removePaymentCardUsecase = removePaymentCardUsecase
        self.getLocationsUsecase = getLocationsUsecase
        self.addLocationUsecase = addLocationUsecase
        self.verifyOrderUsecase = verifyOrderUsecase
        
        super.init()
        
        setup()
    }
    
    @Published var isAllowToShow = false;
    @Published var showBottomSheet = false;
    @Published var verifyOrderInfo: VerifyOrderResponseModel?;
    @Published var paymentMethods : [PaymentMethodResponseModel] = []
    @Published var paymentCards : [PaymentCardResponseModel] = []
    @Published var addresses : [LocationResponseModel] = []
    var currentMethodIndex: Int? = 0
    var currentCardIndex: Int? = 0
    var currentAddressIndex: Int? = 0
    var currentCouponId: String?
    
    func onBack() {
        self.navigator.popLast();
    }
    
    func setup() {
        DispatchQueue.main.async {
            Task {
               // await self.loadPaymentMethods()
                let datastatePaymentMethod = try await self.getPaymentMethodsUsecase.execute()
                if datastatePaymentMethod.isSuccess {
                    self.paymentMethods = (datastatePaymentMethod.data  ?? []) ?? [] ;
                }
                let datastatePaymentCard = try await self.getPaymentCardsUsecase.execute()
                if datastatePaymentCard.isSuccess {
                    self.paymentCards = (datastatePaymentCard.data  ?? []) ?? [] ;
                }
                let datastateAddress = try await self.getLocationsUsecase.execute()
                if datastateAddress.isSuccess {
                    self.addresses = (datastateAddress.data ?? []) ?? [] ;
                }
                let datastate = try await self.verifyOrderUsecase.execute(
                    req:
                                            VerifyOrderDto(
                                                latitude: 0,
                                                longitude: 0,
                                                couponId: nil,
                                                orderType: OrderType.ship.string,
                                                paymentCardId: self.paymentCards.first?.id,
                                                paymentMethodId: self.paymentMethods.first(where: { method in
                                                    method.paymentMethodType == "credit_card"
                                                })?.id
                                            )
                    
                )
                if (datastate.isSuccess) {
                    self.verifyOrderInfo = datastate.data ?? nil;
                }
            }
        }
    }
    
    func processToPayment() {
        withAnimation {
            showBottomSheet = true
        }
    }
    
    func loadPaymentMethods() async throws -> DataState<[PaymentMethodResponseModel]? > {
         return try await self.getPaymentMethodsUsecase.execute()
    }
    
    func loadCard() async throws -> DataState<[PaymentCardResponseModel]?> {
        return try await self.getPaymentCardsUsecase.execute()
    }
    
    func loadAddress() async throws -> DataState<[LocationResponseModel]?> {
        return try await self.getLocationsUsecase.execute()
    }
    
    func addAddress() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let addLocationDto = AddLocationDto(
                    address: "28 Võ Văn Tần, Phường 6, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
                    name: "War Remnants Museum",
                    latitude: 10.7733,
                    longitude: 106.7048,
                    ggPlaceId: "ggPlaceId"
                )
                let datastate = try await self.addLocationUsecase.execute(dto: addLocationDto)
                if (datastate.isSuccess) {
                    let addedLocation: LocationResponseModel? = datastate.data ?? nil
                    if addedLocation != nil {
                        self.addresses.append(addedLocation!)
                    }
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func addCard() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let randomCard = self.generateRandomCard()
                
                let currentDate = Date()
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
                
                let formattedDate = dateFormatter.string(from: currentDate)
                print("Formatted Date and Time: \(formattedDate)")
                
                let addCardDto = AddPaymentCardDto(
                    cardHolderName: "Phan Dam Tung Lam",
                    cardNumber: randomCard.cardNumber,
                    cardType: randomCard.cardType.toString,
                    expirationDate: formattedDate,
                    startDate: formattedDate,
                    billingAddressID: "String",
                    issueNumber: "String"
                )
                
                let datastate = try await self.addPaymentCardUsecase.execute(dto: addCardDto)
                if (datastate.isSuccess) {
                    let addedCard: PaymentCardResponseModel? = datastate.data ?? nil
                    
                    if addedCard != nil {
                        self.paymentCards.append(addedCard!)
                    }
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func confirmPay() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let payDto = PayDto(
                    orderType: OrderType.ship.string,
                    couponId: self.currentCouponId,
                    paymentCardId:
                        (self.paymentMethods)[self.currentMethodIndex ?? 0].paymentMethodType == "credit_card" ?
                    (self.paymentCards)[self.currentCardIndex ?? 0].id : nil,
                    paymentMethodId: (self.paymentMethods)[self.currentMethodIndex ?? 0].id,
                    locationId: self.currentAddressIndex != nil ? self.addresses[self.currentAddressIndex!].id : nil,
                    shipAddress: "135 Tran Hung Dao",
                    latitude: nil,
                    longitude: nil
                )
                let datastate = try await self.payCompleteUsecase.execute(dto: payDto)
                if (datastate.isSuccess) {
                    
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func verifyOrder(req: VerifyOrderDto) {
        DispatchQueue.main.async {
            Task {
                do {
                    let datastate = try await self.verifyOrderUsecase.execute(
                        req: req
                    )
                    if (datastate.isSuccess) {
                        self.verifyOrderInfo = datastate.data ?? nil;
                    }
                } catch {
                    
                }
            }
        }
      
    }
    
    func onSelectCard(index: Int) {
        currentCardIndex = index
    }
    
    func onSelectMethod(index: Int) {
        currentMethodIndex = index
    }
    
    func onSelectAddress(index: Int) {
        currentAddressIndex = index
    }
    
    func navToCoupon() {
        self.navigator.push(RootViewModel.Destination.coupon(
            vm:
                DependencyInjector.instance.viewModelsDI.coupon(
                    navigationCoordinator: self.navigator,
                    args: CouponArgs(
                        onSelect: { couponId in
                            self.currentCouponId = couponId;
                            self.verifyOrder(req: VerifyOrderDto(
                                latitude: 0.0,
                                longitude: 0.0,
                                couponId: couponId,
                                orderType: OrderType.ship.string,
                                paymentCardId:
                                    (self.paymentMethods)[self.currentMethodIndex ?? 0].paymentMethodType == "credit_card" ?
                                (self.paymentCards)[self.currentCardIndex ?? 0].id : nil,
                                paymentMethodId: (self.paymentMethods)[self.currentMethodIndex ?? 0].id,
                                locationId: self.currentAddressIndex != nil ? self.addresses[self.currentAddressIndex!].id : nil
                            )
                            )
                        }
                    )
                )
            )
        )
    }
    
    func generateRandomCardNumber(for cardType: CardType) -> String {
        let prefix = cardType.prefix
        let totalLength = cardType.length
        var cardNumber = prefix
        
        // Generate random digits for the remaining length minus the check digit
        let randomDigitsCount = totalLength - prefix.count - 1
        for _ in 0..<randomDigitsCount {
            cardNumber.append("\(Int.random(in: 0...9))")
        }
        
        // Calculate the check digit using the Luhn algorithm
        let checkDigit = calculateLuhnCheckDigit(for: cardNumber)
        cardNumber.append("\(checkDigit)")
        
        return cardNumber
    }
    
    // Function to calculate the Luhn check digit
    func calculateLuhnCheckDigit(for number: String) -> Int {
        let reversedDigits = number.reversed().compactMap { Int(String($0)) }
        var sum = 0
        
        for (index, digit) in reversedDigits.enumerated() {
            if index % 2 == 0 {
                sum += digit
            } else {
                let doubled = digit * 2
                sum += (doubled > 9) ? doubled - 9 : doubled
            }
        }
        
        let remainder = sum % 10
        return remainder == 0 ? 0 : 10 - remainder
    }
    
    func generateRandomCard() -> (cardType: CardType, cardNumber: String) {
        // Randomly select a card type
        let cardTypes: [CardType] = [.visa, .mastercard, .amex, .discover]
        let selectedCardType = cardTypes.randomElement()!
        
        // Generate a card number for the selected type
        let cardNumber = generateRandomCardNumber(for: selectedCardType)
        
        return (cardType: selectedCardType, cardNumber: cardNumber)
    }
}
