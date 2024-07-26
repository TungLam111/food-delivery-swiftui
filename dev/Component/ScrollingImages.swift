import SwiftUI

struct ScrollingImageCarousel: View {
    @Binding var currentPage: Int
    let imageUrls: [String];
    var onChange : (Int) -> Void;
    
    let carouselHeight: CGFloat = 300 // Set your desired height here

    var body: some View {
        VStack {
            GeometryReader { geometry in
                    HStack(spacing: 0) {
                        ForEach(imageUrls.indices, id: \.self) { index in
                            let imageUrl = imageUrls[index]
                            if imageUrl.starts(with: "https") {
                                AsyncImage(url: URL(string: imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: geometry.size.width, height: carouselHeight)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width, height: carouselHeight)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width, height: carouselHeight)
                                            .clipShape(Circle())
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Image(imageUrl)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: carouselHeight)
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: carouselHeight, alignment: .leading)
                    .offset(x: CGFloat(currentPage) * -geometry.size.width)
                    .animation(.default, value: true)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let offset = value.translation.width
                                if (offset > 10) {
                                    if (self.currentPage >= 1) {
                                        withAnimation {
                                            self.currentPage -= 1
                                        }
                                        onChange(self.currentPage)
                                    }
                                } else if (offset < -10) {
                                    if (self.currentPage < imageUrls.count - 1 ) {
                                        withAnimation {
                                            self.currentPage += 1
                                        }
                                        onChange(self.currentPage)
                                    }
                                }
                            }
                    )
                .frame(width: geometry.size.width, height: carouselHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    // Handle tap gesture if needed
                }
            }.frame(height: carouselHeight)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    if (index == currentPage) {
                         Capsule()
                            .fill(ColorConstants.cFF267860)
                            .frame(width: 40, height: 10)
                    } else {
                         Circle()
                            .fill(ColorConstants.cFFC4C4C4)
                            .frame(width: 10, height: 10)
                       }
                    }
                }
            }
    }
}
