//
//  BookalooTextfield.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct BookalooTextfield: View {
    enum Style {
        case normal
        case secure
        case email
        case numeric
    }
    
    enum Orientation {
        case vertical(Style)
        case horizontal(Style)
    }
    
    @State var title: String
    @Binding var textfieldText: String
    @Binding var valid: Bool?
    @State var placeHolder: String
    @State var orientation: Orientation = .horizontal(.normal)
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
    var normalTextView: some View {
            Text(title)
            .font(StyleConstants.bookalooFont)
            
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .cornerRadius(8)
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .background(Color.textFieldBackgroundColor)
    }
    
    @ViewBuilder
    var emailTextView: some View {
            Text(title)
            .font(StyleConstants.bookalooFont)
        
        VStack(alignment: .leading) {
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .textContentType(.username)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .background(Color.textFieldBackgroundColor)
            
            if let valid, !valid {
                Text("* The email has not correct format.\nExample: something@email.com")
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    var numericTextView: some View {
            Text(title)
            .font(StyleConstants.bookalooFont)
        
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .background(Color.textFieldBackgroundColor)
    }
    
    @ViewBuilder
    var secureTextView: some View {
        Text(title)
        .font(StyleConstants.bookalooFont)

        ZStack(alignment: .trailing) {
            Group {
                VStack(alignment: .leading) {
                    if isSecure {
                        SecureField(placeHolder, text: $textfieldText)
                            .font(StyleConstants.bookalooFont)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.password)
                            .background(Color.textFieldBackgroundColor)
                    } else {
                        TextField(text: $textfieldText) {
                            Text(placeHolder)
                                .font(StyleConstants.bookalooFont)
                        }
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .background(Color.textFieldBackgroundColor)
                    }
                    
                    if let valid, !valid {
                        Text("* The password should have 8 characters or more")
                            .font(.futura(10))
                            .foregroundColor(.red)
                    }
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
    
    func horizontalView(_ style: Style = .normal) -> some View {
        HStack {
            switch style {
            case .normal: normalTextView.padding()
            case .secure: secureTextView.padding()
            case .email: emailTextView.padding()
            case .numeric: numericTextView.padding()
            }
        }
        .padding()
    }
    
    func verticalView(_ style: Style = .normal) -> some View {
        VStack {
            switch style {
            case .normal: normalTextView.padding()
            case .secure: secureTextView.padding()
            case .email: emailTextView.padding()
            case .numeric: numericTextView.padding()
            }
        }
        .padding()
    }
}

struct BookalooTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BookalooTextfield(title: "Introduce datos", textfieldText: .constant(""), valid: .constant(false), placeHolder: "Placeholder Datos")
    }
}
