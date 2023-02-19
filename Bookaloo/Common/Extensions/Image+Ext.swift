//
//  Image+Ext.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

enum SystemImage: String {
    case lock
    case book
    case person
    case cart
    case addPerson = "person.badge.plus"
    case arrowDownLine = "arrow.down.to.line.compact"
    case squareArrowDown = "square.and.arrow.down"
    case pencilLine = "pencil.line"
    case personCircle = "person.crop.circle"
    case arrowTurnUpBackward = "arrowshape.turn.up.backward"
    case starFill = "star.fill"
    case chevronUp = "chevron.up"
    case envelope
    case eye
    case eyeSlash = "eye.slash"
    case magnifyingglass
    case multiplyCircleFill = "multiply.circle.fill"
    case rectangleSlashCircleFill = "rectangle.on.rectangle.slash.circle.fill"
    case photoCircleFill = "photo.circle.fill"
    case trash
    case shippingBoxFill = "shippingbox.fill"
    case trayAndArrowDownFill = "tray.and.arrow.down.fill"
    case pencilCircle = "pencil.circle"
    case cartCircleFill = "cart.circle.fill"
}

extension Image {
    init(systemName: SystemImage) {
        self.init(systemName: systemName.rawValue)
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self.imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
