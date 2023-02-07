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
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ImageLoader(url: imageURL)
                .frame(width: 50)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Title:")
                        .font(StyleConstants.bookalooFont)
                    Text(title)
                        .font(.futura(14))
                        .bold()
                }//: HStack
                
                HStack(alignment: .top) {
                    Text("Author:")
                        .font(StyleConstants.bookalooFont)
                    Text(author)
                        .font(.futura(14))
                        .bold()
                }//: HStack
                
                HStack(alignment: .top) {
                    Text("Year:")
                        .font(StyleConstants.bookalooFont)
                    Text(String(year))
                        .font(.futura(14))
                        .bold()
                }//: Hstack
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
            year: 1985
        ).previewLayout(.sizeThatFits)
    }
}
