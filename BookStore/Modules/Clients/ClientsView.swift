//
//  ClientsView.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct ClientsView: View {
    @ObservedObject var viewModel: ClientsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ClientsView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().clientsView()
    }
}
