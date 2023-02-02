//
//  OrangeButtonView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import SwiftUI

struct OrangeButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Botón")
        }
        .buttonStyle(.miBotonChachi)

    }
}

struct OrangeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OrangeButtonView()
    }
}

extension Font {
    static let futura = Font.custom("Futura", size: 24, relativeTo: .title)
}

class StyleConstants {
    static let gradient = LinearGradient(colors: [.yellow, .cyan], startPoint: .leading, endPoint: .trailing)
}

struct MiBotonChupi: ButtonStyle {
    let gradient = LinearGradient(colors: [.yellow, .cyan], startPoint: .leading, endPoint: .trailing)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.futura)
            .foregroundStyle(StyleConstants.gradient)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(StyleConstants.gradient, lineWidth: 5)
            }
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == MiBotonChupi {
    static var miBotonChachi: MiBotonChupi {
        MiBotonChupi()
    }
}
