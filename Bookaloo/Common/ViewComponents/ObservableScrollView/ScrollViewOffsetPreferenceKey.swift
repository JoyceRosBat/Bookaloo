//
//  ScrollViewOffsetPreferenceKey.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
