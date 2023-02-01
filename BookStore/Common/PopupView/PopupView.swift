//
//  PopupView.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct PopupView<Content: View>: View {
    @Binding var showAlert: Bool
    let title: String
    let message: String
    @ViewBuilder var buttons: () -> Content
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(showAlert ? 0.4 : 0)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                Text(message)
                    .font(.caption)
                HStack(spacing: 30) {
                    buttons()
                }
                .buttonStyle(.bordered)
                .tint(.black)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            .opacity(showAlert ? 1 : 0)
            .offset(y: showAlert ? 0 : 500)
        }
    }
}


struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(showAlert: .constant(true), title: "Atención!!", message: "Aquí ha pasado algo....\nPulsa sobre el botón", buttons: {
            Button {
                print("Hola")
            } label: {
                Text("Aceptar")
            }
            
        })
    }
}
