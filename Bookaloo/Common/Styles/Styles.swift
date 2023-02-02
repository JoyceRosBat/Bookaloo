//
//  Styles.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import SwiftUI

struct BookalooButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.futura)
            .foregroundStyle(StyleConstants.bookalooGradient)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(StyleConstants.blackGradient)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(StyleConstants.bookalooGradient, lineWidth: 5)
            }
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == BookalooButton {
    static var bookalooStyle: BookalooButton {
        BookalooButton()
    }
}
