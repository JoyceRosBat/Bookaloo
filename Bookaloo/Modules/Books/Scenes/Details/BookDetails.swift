//
//  BookDetailsView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

public struct BookDetailsView: View {
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
    
    public var body: some View {
        ZStack {
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
                        
                        RatingView(rating: book.rating ?? 0)
                            .frame(height: 20)
                        
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
                            ZStack {
                                bookImage
                                    .cornerRadius(5)
                                    .frame(width: hideHeader ? 30 : .zero)
                                    .opacity(hideHeader ? 1 : 0)
                                
                                bookImage
                                    .frame(width: viewModel.shopBook ? 0 : 30)
                                    .frame(width: hideHeader ? 30 : .zero)
                                    .opacity(hideHeader ? 1 : 0)
                                    .cornerRadius(5)
                                    .offset(
                                        x: viewModel.shopBook ? screenSize.width - 30 : 0,
                                        y: viewModel.shopBook ? screenSize.height : 0
                                    )
                            }//: ZStack
                            
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
                            
                            Spacer()
                            
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
                                Image(systemName: .cart)
                                    .font(.futura(12))
                            }
                            .buttonStyle(.bookalooStyle)
                            .frame(width: hideHeader ? 30 : .zero)
                            .opacity(hideHeader ? 1 : 0)
                            
                        }//: HStack
                        .padding(.trailing, 16)
                        
                        if let plot = book.plot {
                            
                            Divider()
                            
                            ObservableScrollView(scrollOffset: $scrollOffset) {
                                VStack(alignment: .leading) {
                                    Text(plot)
                                        .lineLimit(seeMore ? nil : 3)
                                        .animation(.easeOut(duration: 0.5), value: seeMore)
                                    
                                    Button {
                                        seeMore.toggle()
                                        scrollOffset = seeMore ? 1 : 0
                                    } label: {
                                        Text(seeMore ? "see_less" : "see_more")
                                            .foregroundStyle(StyleConstants.bookalooGradient)
                                    }//: Button
                                }//: VStack
                                .font(StyleConstants.bookalooFont)
                            } //: ScrollView
                            .scrollIndicators(.hidden)
                            .onChange(of: scrollOffset) { scrollOfset in
                                if scrollOfset <= 0  {
                                    withAnimation(.easeIn(duration: 0.5), {
                                        hideHeader = false
                                    })
                                } else {
                                    if !seeMore {
                                        seeMore.toggle()
                                    }
                                    withAnimation(.easeIn(duration: 0.5), {
                                        hideHeader = true
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
        .toolbar(UIDevice.current.userInterfaceIdiom == .pad ? .visible : .hidden, for: .tabBar)
        .toolbar {
            if UIDevice.current.userInterfaceIdiom != .pad {
                ToolbarItem(placement: .navigationBarTrailing) {
                    BookalooToolbarTitle()
                }//: ToolbarItem - Title
            }
        }//: Toolbar
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            if showErrorMessage {
                fullBooksPopup
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(
            Color.backgroundColor,
            for: .navigationBar
        )
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
    }
}

extension BookDetailsView {
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
