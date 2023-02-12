//
//  UsersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Text("Clients")
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
