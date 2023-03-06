//
//  ModifyUserView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 18/2/23.
//

import SwiftUI

public struct ModifyUserView: View {
    @EnvironmentObject var viewModel: UsersViewModel
    @State var searchText: String = ""
    @FocusState var isFocused: Bool
    
    public var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                HStack {
                    BookalooTextfield(textfieldText: $searchText, orientation: .vertical(.searchable))
                        .focused($isFocused)
                    
                    Button {
                        viewModel.findUser(by: searchText)
                        isFocused = false
                        searchText = ""
                    } label: {
                        Text("search")
                    }//: Button search
                    .buttonStyle(.bookalooStyle)
                }//: HStack
                .padding(.trailing, 16)
                .padding(.horizontal, 8)
            
                UserDataView(user: $viewModel.userFound)
                .focused($isFocused)
                
                Spacer()
            }//: VStack
        }//: BaseViewContent
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            isFocused = false
        }//: onTapGesture
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
        }//: Toolbar
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(
            Color.backgroundColor,
            for: .navigationBar
        )
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
        .onDisappear {
            viewModel.resetUsersValidation()
        }
    }
}

struct ModifyUserView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyUserView()
            .environmentObject(ModuleDependencies().resolve() as UsersViewModel)
    }
}
