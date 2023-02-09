//
//  Text+Extension.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

extension Text {
    func emptyMessageModifier() -> some View {
        self
            .font(.futura(24))
            .multilineTextAlignment(.center)
            .foregroundStyle(StyleConstants.bookalooGradient)
            .padding(16)
    }
}
