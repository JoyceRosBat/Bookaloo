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
    @State var validationText: String?
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
        VStack(alignment: .leading) {
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .cornerRadius(8)
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .background(Color.textFieldBackgroundColor)
            
            if let valid, !valid, let validationText {
                Text("* \(validationText)")
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    var emailTextView: some View {
        VStack(alignment: .leading) {
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .background(Color.textFieldBackgroundColor)
            
            if let valid, !valid, let validationText {
                Text("* \(validationText)")
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    var numericTextView: some View {
        VStack(alignment: .leading) {
            TextField(text: $textfieldText) {
                Text(placeHolder)
                    .font(StyleConstants.bookalooFont)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .background(Color.textFieldBackgroundColor)
            
            if let valid, !valid, let validationText {
                Text("* \(validationText)")
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    var secureTextView: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
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
                }
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: self.isSecure ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
            }
            
            if let valid, !valid, let validationText {
                Text("* \(validationText)")
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }
    }
    
    func horizontalView(_ style: Style = .normal) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(StyleConstants.bookalooFont)
            
            switch style {
            case .normal: normalTextView
                    .padding(.leading, 8)
            case .secure: secureTextView
                    .padding(.leading, 8)
            case .email: emailTextView
                    .padding(.leading, 8)
            case .numeric: numericTextView
                    .padding(.leading, 8)
            }
        }
        .padding()
    }
    
    func verticalView(_ style: Style = .normal) -> some View {
        VStack {
            Text(title)
                .font(StyleConstants.bookalooFont)
            
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
        BookalooTextfield(
            title: "Introduce datos",
            textfieldText: .constant(""),
            valid: .constant(false),
            validationText: "Validation text",
            placeHolder: "Placeholder Datos"
        )
    }
}
