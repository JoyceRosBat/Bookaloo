//
//  BookDetailsView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BookDetailsView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    @State var seeMore: Bool = false
    @State var shop: Bool = false
    var bookImage: some View {
        ImageLoader(url: book.cover)
    }
    
    let book: Book
    let screenSize = UIScreen.main.bounds.size
    let imageHeight: CGFloat = 300
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    bookImage
                        .frame(height: imageHeight)
                        .cornerRadius(5)
                    
                    bookImage
                        .frame(height: shop ? 0 : imageHeight)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                        .offset(x: shop ? screenSize.width - 100 : 0, y: shop ? screenSize.height : 0)
                }
                
                Text(book.title)
                    .font(.futura(24))
                    .bold()
                
                Button {
                    withAnimation(.easeInOut(duration: 2)) {
                        shop = true
                        viewModel.addToCart(book)
                    }
                } label: {
                    Text("Shop")
                }
                .buttonStyle(.bookalooStyle)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Author:")
                            .bold()
                        Text(book.author)
                    }//:Hstack
                    .font(StyleConstants.bookalooFont)
                    
                    HStack(alignment: .top) {
                        Text("Year:")
                            .bold()
                        Text("\(book.year)")
                    }//: HStack
                    .font(StyleConstants.bookalooFont)
                    
                    if let plot = book.plot {
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text(plot)
                                .lineLimit(seeMore ? nil : 3)
                                .animation(.easeOut(duration: 0.5), value: seeMore)
                            
                            Button {
                                seeMore.toggle()
                            } label: {
                                Text(seeMore ? "See less..." : "See more...")
                                    .foregroundStyle(StyleConstants.bookalooGradient)
                            }//: Button
                        }//: VStack
                        .font(StyleConstants.bookalooFont)
                    }//: If there is plot
                }//: VStack
                .padding(.top, 16)
                
                Spacer()
            }//: VStack
            .padding()
        } //: ScrollView
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().bookDetailsView(.test)
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
