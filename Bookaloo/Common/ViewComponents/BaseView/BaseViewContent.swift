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
    var errorPopup: some View {
        PopupView(
            showAlert: $viewModel.showError,
            title: LocalizedStringKey(viewModel.alertTitle)) {
                Text(LocalizedStringKey(viewModel.alertMessage))
            } buttons: {
                Button {
                    viewModel.showError.toggle()
                } label: {
                    Text("accept")
                }
            }
    }
}

struct BaseViewContent_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewContent(viewModel: ObservableBaseViewModel(), content: {
            ModuleDependencies().resolve() as HomeView
        })
    }
}
