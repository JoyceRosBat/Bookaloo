//
//  BookDetailsView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BookDetailsView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    @State var seeMore: Bool = false
    @State var showErrorMessage: Bool = false
    var bookImage: some View {
        ImageLoader(url: book.cover)
    }
    
    let book: Book
    let screenSize = UIScreen.main.bounds.size
    let imageHeight: CGFloat = 300
    
    @State var scrollOffset: CGFloat = 0
    @State var hideHeader: Bool = false
    
    var body: some View {
        var rating = book.rating
        let bindingRating = Binding(
            get: { Int(rating ?? 0) },
            set: { rating = Double($0) }
        )
        
        return ZStack {
            ZStack {
                Color.backgroundColor
                VStack(spacing: 0) {
                    VStack {
                        ZStack {
                            bookImage
                                .frame(height: imageHeight)
                                .cornerRadius(5)
                            
                            bookImage
                                .frame(height: viewModel.shopBook ? 0 : imageHeight)
                                .cornerRadius(5)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                .offset(
                                    x: viewModel.shopBook ? screenSize.width - 100 : 0,
                                    y: viewModel.shopBook ? screenSize.height : 0
                                )
                        }//: ZStack
                        
                        Text(book.title)
                            .font(.futura(24))
                            .bold()
                        
                        RatingView(rating: bindingRating, allowTouch: false)
                        
                        if let price = book.price {
                            Text(String(format: "%.2f%@", price, Locale.current.currencySymbol ?? "€"))
                                .font(.futura(24))
                                .bold()
                                .foregroundColor(.green)
                                .opacity(0.7)
                        }
                        
                        Button {
                            if viewModel.booksToShop[book.apiID, default: -1] < 10 {
                                withAnimation(.easeInOut(duration: 2)) {
                                    viewModel.shopBook = true
                                    viewModel.addToCart(book)
                                }
                            } else {
                                showErrorMessage = true
                            }
                        } label: {
                            Label("shop", systemImage: .cart)
                        }
                        .buttonStyle(.bookalooStyle)
                    }//: VStack
                    .frame(height: hideHeader ? .zero : nil)
                    .opacity(hideHeader ? 0 : 1)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            bookImage
                                .cornerRadius(5)
                                .frame(width: hideHeader ? 30 : .zero)
                                .opacity(hideHeader ? 1 : 0)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .top) {
                                    Text("author_title")
                                        .bold()
                                    Text(book.author)
                                }//:Hstack
                                .font(StyleConstants.bookalooFont)
                                
                                HStack(alignment: .top) {
                                    Text("year_title")
                                        .bold()
                                    Text("\(book.year)")
                                }//: HStack
                                .font(StyleConstants.bookalooFont)
                            }//: VStack
                            .ignoresSafeArea()
                        }//: HStack
                        
                        if let plot = book.plot {
                            
                            Divider()
                            
                            ObservableScrollView(scrollOffset: $scrollOffset) {
                                VStack(alignment: .leading) {
                                    Text(plot)
                                        .lineLimit(seeMore ? nil : 3)
                                        .animation(.easeOut(duration: 0.5), value: seeMore)
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            seeMore.toggle()
                                        }
                                    } label: {
                                        Text(seeMore ? "see_less" : "see_more")
                                            .foregroundStyle(StyleConstants.bookalooGradient)
                                    }//: Button
                                }//: VStack
                                .font(StyleConstants.bookalooFont)
                            } //: ScrollView
                            .scrollIndicators(.hidden)
                            .onChange(of: scrollOffset) { scrollOfset in
                                if scrollOfset > 0 {
                                    withAnimation(.easeIn(duration: 0.5), {
                                        hideHeader = true
                                    })
                                } else if scrollOfset < 0 {
                                    withAnimation(.easeIn(duration: 0.5), {
                                        hideHeader = false
                                    })
                                }
                            }//: OnChange scroll
                        }//: If there is plot
                    }//: VStack
                    .padding(.top, 16)
                    
                    Spacer()
                }//: VStack
                .padding()
            }//: ZStack
        }//: ZStack
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
        }//: Toolbar
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            if showErrorMessage {
                fullBooksPopup
            }
        }
    }
}

extension BookDetailsView {
    @ViewBuilder
    var fullBooksPopup: some View {
        PopupView(
            showAlert: $showErrorMessage,
            title: "Warning") {
                Text("max_books_reached")
            } buttons: {
                Button {
                    showErrorMessage.toggle()
                } label: {
                    Text("accept")
                }
            }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().resolve(.test)
            .environmentObject(ModuleDependencies().resolve() as ShopViewModel)
    }
}
