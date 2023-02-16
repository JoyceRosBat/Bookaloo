//
//  UsersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    @State var searchText: String = ""
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                HStack {
                    BookalooTextfield(textfieldText: $searchText, orientation: .vertical(.searchable))
                    //Is this necessary??
//                        .onChange(of: searchText) { _ in
//                            //TODO: Clear the user's data
//                        }
                    
                    Button {
                        viewModel.findUser(by: searchText)
                        searchText = ""
                    } label: {
                        Text("Search")
                    }//: Button search
                    .buttonStyle(.bookalooStyle)
                }
                .padding(.trailing, 16)
                .padding(.horizontal, 8)
            
                UserDataView(user: $viewModel.userFound)
                
                Spacer()
            }
        }//: BaseViewContent
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
        }//: Toolbar
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().usersView()
    }
}
