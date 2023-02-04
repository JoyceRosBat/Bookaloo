//
//  Loader.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 4/2/23.
//

import SwiftUI

struct Loader: View {
    @State private var animate: Bool = false
        
        var body: some View {
            ZStack {
                Color.black
                    .opacity(animate ? 0.4 : 0)
                    .ignoresSafeArea()
                HStack {
                    Circle()
                        .fill(Color.cyan)
                        .frame(width: 20, height: 20)
                        .scaleEffect(animate ? 1.0 : 0.5)
                        .animation(
                            .easeInOut(
                                duration: 0.5)
                            .repeatForever(),
                            value: animate
                        )
                    Circle()
                        .fill(StyleConstants.bookalooGradient)
                        .frame(width: 20, height: 20)
                        .scaleEffect(animate ? 1.0 : 0.5)
                        .animation(
                            .easeInOut(
                                duration: 0.5)
                            .repeatForever()
                            .delay(0.3),
                            value: animate
                        )
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                        .scaleEffect(animate ? 1.0 : 0.5)
                        .animation(
                            .easeInOut(
                                duration: 0.5)
                            .repeatForever()
                            .delay(0.6),
                            value: animate
                        )
                }
            }
            .onAppear {
                animate = true
            }
        }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
