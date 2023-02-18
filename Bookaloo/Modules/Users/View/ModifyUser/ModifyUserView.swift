//
//  ModifyUserView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 18/2/23.
//

import SwiftUI

struct ModifyUserView: View {
    @EnvironmentObject var viewModel: UsersViewModel
    @State var searchText: String = ""
    @FocusState var isFocused: Bool
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                HStack {
                    BookalooTextfield(textfieldText: $searchText, orientation: .vertical(.searchable))
                    
                    Button {
                        viewModel.findUser(by: searchText)
                        searchText = ""
                    } label: {
                        Text("Search")
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
        .onTapGesture {
            isFocused = false
        }//: onTapGesture
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
        }//: Toolbar
        .toolbar(.hidden, for: .tabBar)
    }
}

struct ModifyUserView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyUserView()
            .environmentObject(ModuleDependencies().usersViewModel())
    }
}
