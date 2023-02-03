//
//  BaseViewContent.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import SwiftUI

struct BaseViewContent<Content: View>: View {
    @ObservedObject var viewModel: ObservableBaseViewModel
    @ViewBuilder var content: () -> Content
    var body: some View {
        VStack {
            content()
        }
        .padding(.bottom, 200)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            PopupView(
                showAlert: $viewModel.showAlert,
                title: viewModel.alertTitle,
                message: viewModel.alertMessage) {
                    Button {
                        viewModel.showAlert.toggle()
                    } label: {
                        Text("Aceptar")
                    }
                    
                }
        }
        .animation(.default, value: viewModel.showAlert)
        .onAppear {
            viewModel.onAppear()
        }
        .background(Color.backgroundColor)
    }
}

struct BaseViewContent_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewContent(viewModel: ObservableBaseViewModel(), content: {
            ModuleDependencies().booksView()
        })
    }
}
