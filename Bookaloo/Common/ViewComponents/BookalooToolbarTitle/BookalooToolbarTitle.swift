//
//  BookalooToolbarTitle.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import SwiftUI

struct BookalooToolbarTitle: View {
    var body: some View {
        Text("Bookaloo")
            .font(.futura(24))
            .bold()
            .foregroundStyle(StyleConstants.bookalooGradient)
    }
}

struct BookalooToolbarTitle_Previews: PreviewProvider {
    static var previews: some View {
        BookalooToolbarTitle()
    }
}
