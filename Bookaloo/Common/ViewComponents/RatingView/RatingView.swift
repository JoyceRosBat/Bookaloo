//
//  RatingView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 13/2/23.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    var maxRating = 5
  
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: .starFill)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        stars.overlay(
            GeometryReader { geo in
                let width = rating / CGFloat(maxRating) * geo.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }//: ZStack
            }//: GeometryReader
            .mask(stars)
        )//: Overlay
        .foregroundColor(.gray)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 2.5)
    }
}

