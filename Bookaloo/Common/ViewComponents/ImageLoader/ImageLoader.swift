//
//  ImageLoader.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct ImageLoader: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(
            url: url,
            transaction: Transaction(
                animation: .spring(
                    response: 0.5,
                    dampingFraction: 0.6,
                    blendDuration: 0.25
                )
            )
        ) { phase in
            switch phase {
            case .success(let image):
                image.imageModifier()
                    .transition(.scale)
            case .failure:
                Image(systemName: .rectangleSlashCircleFill).iconModifier()
            case .empty:
                Image(systemName: .photoCircleFill).iconModifier()
            @unknown default:
                ProgressView()
            }
        }
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader(url: URL(string: "https://images.gr-assets.com/books/1327942880l/2493.jpg"))
    }
}
