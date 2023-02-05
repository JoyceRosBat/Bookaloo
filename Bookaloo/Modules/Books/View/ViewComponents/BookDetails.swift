//
//  BookDetailsView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BookDetailsView: View {
    let book: Book
    
    var body: some View {
        Text(book.title)
            .toolbar(.hidden, for: .tabBar)
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().bookDetailsView(.test)
    }
}
