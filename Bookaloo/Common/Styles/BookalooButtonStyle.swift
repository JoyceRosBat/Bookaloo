//
//  BookalooButtonStyle.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import SwiftUI

struct BookalooButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(StyleConstants.bookalooFont)
            .foregroundStyle(StyleConstants.bookalooGradient)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(StyleConstants.blackGradient.opacity(0.8))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(StyleConstants.bookalooGradient, lineWidth: 3)
            }
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == BookalooButton {
    static var bookalooStyle: BookalooButton {
        BookalooButton()
    }
}
