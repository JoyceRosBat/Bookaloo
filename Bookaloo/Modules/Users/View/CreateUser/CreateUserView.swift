//
//  CreateUserView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 18/2/23.
//

import SwiftUI

struct CreateUserView: View {
    var body: some View {
        VStack {
            Text("Create user")
        }//: VStack
        .toolbar(.hidden, for: .tabBar)
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
