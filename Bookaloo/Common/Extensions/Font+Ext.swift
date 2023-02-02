//
//  Fonts.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import SwiftUI

extension Font {
    static func futura(_ size: CGFloat = 16) -> Font {
        .custom("Futura", size: size, relativeTo: .title)
    }
}
