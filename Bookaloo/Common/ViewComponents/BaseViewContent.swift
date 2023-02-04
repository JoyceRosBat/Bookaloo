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
            if viewModel.showLoading {
                Loader()
            }
            if viewModel.showError {
                errorPopup
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .background(Color.backgroundColor)
    }
}

extension BaseViewContent {
    @ViewBuilder
    var errorPopup: some View {
        PopupView(
            showAlert: $viewModel.showError,
            title: viewModel.alertTitle,
            message: viewModel.alertMessage) {
                Button {
                    viewModel.showError.toggle()
                } label: {
                    Text("Accept")
                }
                
            }
    }
}

struct BaseViewContent_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewContent(viewModel: ObservableBaseViewModel(), content: {
            ModuleDependencies().booksView()
        })
    }
}
