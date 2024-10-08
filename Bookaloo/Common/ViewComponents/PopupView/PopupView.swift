//
//  PopupView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct PopupView<TextContent: View, ButtonsContent: View>: View {
    @Binding var showAlert: Bool
    let title: LocalizedStringKey
    @ViewBuilder var message: () -> TextContent
    @ViewBuilder var buttons: () -> ButtonsContent
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(showAlert ? 0.4 : 0)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Group {
                    Text(title)
                        .font(.headline)
                        .padding(.top, 24)
                        .multilineTextAlignment(.center)
                    message()
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .padding(.leading, 24)
                .padding(.trailing, 24)
                
                HStack(spacing: 30) {
                    buttons()
                }
                .padding()
                .buttonStyle(.bookalooStyle())
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.backgroundColor)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            .padding()
            .opacity(showAlert ? 1 : 0)
            .offset(y: showAlert ? 0 : 500)
        }
    }
}


struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(
            showAlert: .constant(true),
            title: "Atención!!") {
                Text("Aquí ha pasado algo....\nPulsa sobre el botón")
            } buttons: {
                Button {
                    print("Hola")
                } label: {
                    Text("Aceptar")
                }
            }
    }
}
