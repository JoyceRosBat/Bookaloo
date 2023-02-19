//
//  ObservableScrollView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import SwiftUI

struct ObservableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    @Binding var scrollOffset: CGFloat
    let content: () -> Content
    
    init(scrollOffset: Binding<CGFloat>,
         @ViewBuilder content: @escaping () -> Content) {
        _scrollOffset = scrollOffset
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            content()
                .background(
                    GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    }
                )
            
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

struct ObservableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableScrollView(scrollOffset: .constant(0), content: {
            ForEach(0..<10) { index in
                Text("Hello \(index)")
            }
        })
    }
}
