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
    
    init(
        navigator: NavigationCoordinator,
        getPaymentMethodsUsecase: GetPaymentMethodUsecase,
        getPaymentCardsUsecase: GetPaymentCardsUsecase,
        addPaymentCardUsecase: AddPaymentCardUsecase,
        payCompleteUsecase: PaymentCompleteUsecase,
        removePaymentCardUsecase: RemovePaymentCardUsecase,
        getLocationsUsecase: GetLocationUsecase,
        addLocationUsecase: AddLocationUsecase
    ) {
        self.navigator = navigator
        self.getPaymentMethodsUsecase = getPaymentMethodsUsecase
        self.getPaymentCardsUsecase = getPaymentCardsUsecase
        self.addPaymentCardUsecase = addPaymentCardUsecase
        self.payCompleteUsecase = payCompleteUsecase
        self.removePaymentCardUsecase = removePaymentCardUsecase
        self.getLocationsUsecase = getLocationsUsecase
        self.addLocationUsecase = addLocationUsecase
        
        super.init()
        
        setup()
    }
    
    @Published var isAllowToShow = false;
    @Published var showBottomSheet = false;
    @Published var promocode = ""
    
    @Published var paymentMethods : [PaymentMethodResponseModel] = []
    
    @Published var paymentCards : [PaymentCardResponseModel] = []
    
    @Published var addresses : [LocationResponseModel] = []
    
    func onBack() {
        self.navigator.popLast();
    }
    
    func setup() {
        loadPaymentMethods()
        loadCard()
        loadAddress()
    }
    
    func processToPayment() {
        withAnimation {
            showBottomSheet = true
        }
    }
    
    func loadPaymentMethods() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let datastate = try await self.getPaymentMethodsUsecase.execute()
                if (datastate.isSuccess) {
                    self.paymentMethods = (datastate.data ?? []) ?? [] ;
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func loadCard() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let datastate = try await self.getPaymentCardsUsecase.execute()
                if (datastate.isSuccess) {
                    self.paymentCards = (datastate.data ?? []) ?? [] ;
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func loadAddress() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let datastate = try await self.getLocationsUsecase.execute()
                if (datastate.isSuccess) {
                    self.addresses = (datastate.data ?? []) ?? [] ;
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func addAddress() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                
                let addLocationDto = AddLocationDto(
                    address: "123 John Street, Neywork, USA",
                    name: "123 John Street, Neywork, USA",
                    latitude: 222222,
                    longitude: 111111,
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
                
                // Get the current date and time
                let currentDate = Date()
                
                // Create a DateFormatter
                let dateFormatter = DateFormatter()
                
                // Set the desired date format
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
                
                // Format the current date
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
    
    // Function to generate a random card number
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
    
    func confirmPay() {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let payDto = PayDto(
                    orderType: "ship",
                    couponId: "coupon_id",
                    paymentCardId: "payment_card_id",
                    paymentMethodId: "payment_method_id",
                    locationId: nil,
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
}
