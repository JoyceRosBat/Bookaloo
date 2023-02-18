//
//  BookCellView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BookCellView: View {
    let imageURL: URL?
    let title: String
    let author: String
    let year: Int
    @State var rating: Double?
    let purchased: Bool
    let price: Double?
    
    var body: some View {
        let bindingRating = Binding(
            get: { Int(rating ?? 0) },
            set: { rating = Double($0) }
        )
        
        return HStack(alignment: .center, spacing: 16) {
                ImageLoader(url: imageURL)
                    .frame(width: 60)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                VStack(alignment: .leading) {
                            Text(title)
                                .font(.futura(14))
                                .bold()
                    
                        Text(author)
                            .font(.futura(14))
                            .bold()
                            .foregroundColor(.accentColor)
                            .opacity(0.6)
                    
                        Text(String(year))
                            .font(.futura(14))
                            .bold()
                            .foregroundColor(.gray)
                    
                    if let price {
                        Text(String(format: "%.2f%@", price, Locale.current.currencySymbol ?? "€"))
                            .font(.futura(14))
                            .bold()
                            .foregroundColor(.green)
                            .opacity(0.7)
                    }
                    
                       RatingView(rating: bindingRating, allowTouch: false)
                }//: VStack
                
                Spacer()
                
                VStack(alignment: .center) {
                    if purchased {
                        Image(systemName: "cart.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(StyleConstants.bookalooGradient)
                    }//: If purchased...
                }//: VStack
                
            }//: HStack
    }
}

struct BookCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookCellView(
            imageURL: URL(string: "https://images.gr-assets.com/books/1327942880l/2493.jpg"),
            title: "The Time Machine",
            author: "H. G. Wells",
            year: 1985,
            rating: 3.5,
            purchased: true,
            price: 10.95
        ).previewLayout(.sizeThatFits)
    }
}
