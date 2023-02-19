//
//  Label+Ext.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(_ title: LocalizedStringKey, systemImage: SystemImage) {
        self.init(title, systemImage: systemImage.rawValue)
    }

    init<S: StringProtocol>(_ titleString: S, systemIcon: SystemImage) {
        self.init(titleString, systemImage: systemIcon.rawValue)
    }
}
