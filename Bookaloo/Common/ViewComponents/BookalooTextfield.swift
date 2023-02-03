//
//  BookalooTextfield.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct BookalooTextfield: View {
    enum Style {
        case plain
        case secure
    }
    
    enum Orientation {
        case vertical(Style)
        case horizontal(Style)
    }
    
    @State var title: String
    @Binding var textfieldText: String
    @State var placeHolder: String
    @State var orientation: Orientation = .horizontal(.plain)
    @State private var isSecure: Bool = true
    
    var body: some View {
        switch orientation {
        case .vertical(let style): verticalView(style)
        case .horizontal(let style): horizontalView(style)
        }
    }
}

private extension BookalooTextfield {
    @ViewBuilder
    var bodyView: some View {
            Text(title)
            .font(StyleConstants.bookalooFont)
            
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
    }
    
    @ViewBuilder
    var secureBodyView: some View {
        Text(title)
        .font(StyleConstants.bookalooFont)

        ZStack(alignment: .trailing) {
            Group {
                if isSecure {
                    SecureField(placeHolder, text: $textfieldText)
                        .font(StyleConstants.bookalooFont)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                } else {
                    TextField(text: $textfieldText) {
                        Text(placeHolder)
                            .font(StyleConstants.bookalooFont)
                    }
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                }
            }.padding(.trailing, 32)
            
            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: self.isSecure ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
    
    func horizontalView(_ style: Style = .plain) -> some View {
        HStack {
            switch style {
            case .plain: bodyView.padding()
            case .secure: secureBodyView.padding()
            }
        }
        .padding()
    }
    
    func verticalView(_ style: Style = .plain) -> some View {
        VStack {
            switch style {
            case .plain: bodyView.padding()
            case .secure: secureBodyView.padding()
            }
        }
        .padding()
    }
}

struct BookalooTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BookalooTextfield(title: "Introduce datos", textfieldText: .constant(""), placeHolder: "Placeholder Datos")
    }
}
