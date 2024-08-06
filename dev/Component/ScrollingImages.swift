import SwiftUI

struct ScrollingImageCarousel<Content: View>: View {
    @Binding var currentPage: Int
    let data: [Any];
    var onChange : (Int) -> Void;
    var itemCount: Int;
    var itemBuilder: (Int) -> Content;
    var carouselHeight: CGFloat;

    var body: some View {
        VStack {
            GeometryReader { geometry in
                    HStack(spacing: 0) {
                        ForEach(data.indices, id: \.self) { index in
                            itemBuilder(index)
                               .tag(index)
                               .frame(
                                width: geometry.size.width,
                                height: carouselHeight
                            )
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
                                    if (self.currentPage < itemCount - 1 ) {
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
            
            Spacer().frame(height: 20)
            
            HStack(alignment: .center, spacing: 10) {
                ForEach(data.indices, id: \.self) { index in
                    if (index == currentPage) {
                         Capsule()
                            .fill(ColorConstants.cFF000000)
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
