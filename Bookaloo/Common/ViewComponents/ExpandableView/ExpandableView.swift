//
//  ExpandableView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

struct ExpandableView<Header: View, Content: View>: View {
    @State var isExpanded: Bool = false
    
    var header: () -> Header
    var content: () -> Content
    
    var body: some View {
        Section {
            Section {
                if isExpanded {
                    content()
                }
            } header: {
                    Button {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    } label: {
                        HStack {
                            header()
                            
                            Spacer()
                            
                            Image(systemName: .chevronUp)
                                .rotationEffect(.degrees(isExpanded ? 180 : 360))
                                .animation(Animation.easeInOut(duration: 0.2), value: isExpanded)
                        }
                    }
                    .buttonStyle(.plain)
            }
        }
    }
}

struct ExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(0..<5) { index in
                Section {
                    ExpandableView(header: {
                        Text("Label test")
                    },
                                   content: {
                        ForEach(0..<5) { index in
                            Text("Content test \(index + 1)")
                        }
                    })
                    .padding()
                }
            }
        }
    }
}
