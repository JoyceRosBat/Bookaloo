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
        ZStack {
            Color.backgroundColor
            content()
        }
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