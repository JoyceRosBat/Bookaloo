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
        case searchable
    }
    
    enum Orientation {
        case vertical(Style)
        case horizontal(Style)
    }
    
    @State var title: String?
    @Binding var textfieldText: String
    @Binding var valid: Bool
    @State var validationText: LocalizedStringKey?
    @State var placeHolder: LocalizedStringKey?
    @State var orientation: Orientation
    var cleanSearchAction: (() -> Void)?
    var showTextfieldIcon: Bool = true
    
    @State private var isSecure: Bool = true
    @State private var isSearching: Bool = false
    
    init(textfieldText: Binding<String>,
         title: String? = nil,
         valid: Binding<Bool> = .constant(false),
         validationText: String? = nil,
         placeHolder: String? = nil,
         orientation: Orientation = .horizontal(.normal),
         showTextfieldIcon: Bool = true,
         cleanSearchAction: (() -> Void)? = nil) {
        self._textfieldText = textfieldText
        self.title = title
        self._valid = valid
        self.validationText = LocalizedStringKey(validationText ?? "")
        self.placeHolder = LocalizedStringKey(placeHolder ?? "")
        self.orientation = orientation
        self.cleanSearchAction = cleanSearchAction
        self.showTextfieldIcon = showTextfieldIcon
    }
    
    var body: some View {
        switch orientation {
        case .vertical(let style): verticalView(style)
        case .horizontal(let style): horizontalView(style)
        }
    }
}

private extension BookalooTextfield {
    // MARK: - Normal
    @ViewBuilder
    var normalTextView: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder ?? "", text: $textfieldText)
                .font(StyleConstants.bookalooFont)
                .padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5)
                        .opacity(0.5)
                )
                .multilineTextAlignment(.leading)
                .background(Color.textFieldBackgroundColor)
                .cornerRadius(8)
            
            if let valid, !valid, let validationText {
                Text(validationText)
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }//: VStack
    }
    
    // MARK: - Email
    @ViewBuilder
    var emailTextView: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder ?? "", text: $textfieldText)
                .font(StyleConstants.bookalooFont)
                .padding(EdgeInsets(top: 8, leading: showTextfieldIcon ? 36 : 18, bottom: 8, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5)
                        .opacity(0.5)
                )
                .multilineTextAlignment(.leading)
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .background(Color.textFieldBackgroundColor)
                .overlay(
                    HStack {
                        if showTextfieldIcon {
                            Image(systemName: .envelope)
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    }
                )
                .cornerRadius(8)
            
            
            if let valid, !valid, let validationText {
                Text(validationText)
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }//: VStack
    }
    
    // MARK: - Numeric
    @ViewBuilder
    var numericTextView: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder ?? "", text: $textfieldText)
                .font(StyleConstants.bookalooFont)
                .padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5)
                        .opacity(0.5)
                )
                .multilineTextAlignment(.leading)
                .keyboardType(.numberPad)
                .background(Color.textFieldBackgroundColor)
                .cornerRadius(8)
            
            if let valid, !valid, let validationText {
                Text(validationText)
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }//: VStack
    }
    
    // MARK: - Secure
    @ViewBuilder
    var secureTextView: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    if isSecure {
                        SecureField(placeHolder ?? "", text: $textfieldText)
                            .padding(EdgeInsets(top: 0, leading: showTextfieldIcon ? 18 : 0, bottom: 0, trailing: 18))
                            .font(StyleConstants.bookalooFont)
                            .padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 0.5)
                                    .opacity(0.5)
                            )
                            .overlay(
                                HStack {
                                    if showTextfieldIcon {
                                        Image(systemName: .lock)
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 8)
                                    }// If show icon
                                }//: HStack
                            )
                            .textContentType(.password)
                            .background(Color.textFieldBackgroundColor)
                            .cornerRadius(8)
                    } // If is secure entry
                    else {
                        TextField(placeHolder ?? "", text: $textfieldText)
                            .padding(EdgeInsets(top: 8, leading: showTextfieldIcon ? 32 : 18, bottom: 8, trailing: 20))
                            .font(StyleConstants.bookalooFont)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 0.5)
                                    .opacity(0.5)
                            )
                            .multilineTextAlignment(.leading)
                            .textContentType(.password)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .background(Color.textFieldBackgroundColor)
                            .overlay(
                                HStack {
                                    if showTextfieldIcon {
                                        Image(systemName: .lock)
                                            .foregroundColor(.gray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 8)
                                    }
                                }
                            )
                            .cornerRadius(8)
                    }
                }//: VStack
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: self.isSecure ? .eyeSlash : .eye)
                        .accentColor(.gray)
                }//: Button
            }//: HStack
            
            if let valid, !valid, let validationText {
                Text(validationText)
                    .font(.futura(10))
                    .foregroundColor(.red)
            }
        }//: VStack
    }
    
    // MARK: - Searchable
    @ViewBuilder
    var searchableText: some View {
        TextField(placeHolder ?? "", text: $textfieldText)
            .font(StyleConstants.bookalooFont)
            .padding(EdgeInsets(top: 8, leading: showTextfieldIcon ? 32 : 18, bottom: 8, trailing: 32))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .opacity(0.5)
            )
            .multilineTextAlignment(.leading)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .background(Color.textFieldBackgroundColor)
            .overlay(
                HStack {
                    if showTextfieldIcon {
                        Image(systemName: .magnifyingglass)
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isSearching {
                            Button(action: {
                                textfieldText = ""
                                cleanSearchAction?()
                            }) {
                                Image(systemName:.multiplyCircleFill)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }//: Button
                        }// If is searching
                    }//: If show icon
                }//: HStack
            )
            .cornerRadius(8)
            .onChange(of: textfieldText) { newValue in
                isSearching = !newValue.isEmpty
            }
    }
    
    func horizontalView(_ style: Style = .normal) -> some View {
        HStack(alignment: .top) {
            if let title {
                Text(title)
                    .font(StyleConstants.bookalooFont)
                    .foregroundColor(.accentColor)
            }
            
            switch style {
            case .normal: normalTextView
                    .padding(.leading, 8)
            case .secure: secureTextView
                    .padding(.leading, 8)
            case .email: emailTextView
                    .padding(.leading, 8)
            case .numeric: numericTextView
                    .padding(.leading, 8)
            case .searchable: searchableText
            }
        }//: HStack
        .padding()
    }
    
    func verticalView(_ style: Style = .normal) -> some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(StyleConstants.bookalooFont)
                    .foregroundColor(.accentColor)
            }
            
            switch style {
            case .normal: normalTextView
            case .secure: secureTextView
            case .email: emailTextView
            case .numeric: numericTextView
            case .searchable: searchableText
            }
        }//: VStack
        .padding()
    }
}

struct BookalooTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BookalooTextfield(textfieldText: .constant(""), title: "Title", placeHolder: "Placeholder", orientation: .vertical(.secure))
    }
}
