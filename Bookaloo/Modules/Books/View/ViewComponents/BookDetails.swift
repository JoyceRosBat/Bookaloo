//
//  BookDetailsView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BookDetailsView: View {
    let book: Book
    @State var seeMore: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                ImageLoader(url: book.cover)
                    .frame(width: 200)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Text(book.title)
                    .font(.futura(24))
                    .bold()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Author:")
                            .bold()
                        Text(book.author)
                    }
                    .font(StyleConstants.bookalooFont)
                    
                    HStack(alignment: .top) {
                        Text("Year:")
                            .bold()
                        Text("\(book.year)")
                    }
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
                            }
                        }
                        .font(StyleConstants.bookalooFont)
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .padding()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().bookDetailsView(.test)
    }
}
