import SwiftUI

struct CouponView: View {
    @StateObject var viewModel: CouponViewModel
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            ScrollView {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            viewModel.onBack()
                        }
                    
                    Spacer()
                    
                    Text("Coupon")
                        .font(.custom(FontConstants.defautFont, size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(ColorConstants.cFF2E2E2D)
                .cornerRadius(10)
                
                Spacer().frame(height: 20)
                
                ForEach(viewModel.coupons) { coupon in
                    VStack (alignment: .leading) {
                        HStack {
                            Text(coupon.code)
                                .font(.custom(FontConstants.defautFont, size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(ColorConstants.cFF67544A)
                                .padding(.trailing, 10)
                            Spacer()
                            
                            if coupon.couponType == "discount", let discount = coupon.discountPercentage {
                                Text("\(discount, specifier: "%.0f")% OFF")
                                    .font(.custom(FontConstants.defautFont, size: 18))
                                    .fontWeight(.medium)
                                    .foregroundColor(ColorConstants.cFF267860)
                            } else {
                                Text("Free Shipping")
                                    .font(.custom(FontConstants.defautFont, size: 18))
                                    .fontWeight(.medium)
                                    .foregroundColor(ColorConstants.cFF9D724D)
                            }
                        }
                        
                        Text(coupon.description)
                            .font(.custom(FontConstants.defautFont, size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 10)
                        
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Expiry: \(formattedDate(coupon.expiryDate) ?? "")")
                                    .font(.custom(FontConstants.defautFont, size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(ColorConstants.cFF67544A)
                                Spacer().frame(height: 10)
                                Text("Min Spend: $\(coupon.minimumSpend, specifier: "%.2f")")
                                    .font(.custom(FontConstants.defautFont, size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(ColorConstants.cFF67544A)
                            }
                            
                            Spacer()
                            
                            Text("Use")
                                .font(.custom(FontConstants.defautFont, size: 16))
                                .foregroundColor(ColorConstants.cFF67544A)
                        }
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                    .onTapGesture {
                        viewModel.onSelectCoupon(coupon: coupon)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 60)
        .padding(.horizontal, 20)
        .background(ColorConstants.cFFF2F2F2)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
    
    // Helper function to format the date
    func formattedDate(_ isoDateString: String) -> String? {
        // Create a DateFormatter for parsing the input ISO 8601 date string
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // Parse the date string into a Date object
        guard let date = isoFormatter.date(from: isoDateString) else {
            print("Failed to parse date string: \(isoDateString)")
            return nil
        }
        
        // Create a DateFormatter for formatting the Date object into the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        
        // Format the date and return the string
        return outputFormatter.string(from: date)
    }
    
}

#Preview {
    CouponView(
        viewModel: DependencyInjector.instance.viewModelsDI.coupon(navigationCoordinator: RootViewModel(),
                                                                   args: CouponArgs(onSelect: { String in
                                                                   }))
        
    )
}
